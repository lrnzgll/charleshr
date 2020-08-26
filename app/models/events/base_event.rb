
# Kickstarter code reference:
# https://github.com/pcreux/event-sourcing-rails-todo-app-demo/blob/master/app/models/lib/base_event.rb

class Events::BaseEvent < ActiveRecord::Base
  delegate :aggregate_name, to: :class

  before_validation :find_or_build_aggregate
  before_create :apply_and_persist

  self.abstract_class = true

  def apply(aggregate)
    raise NotImplementedError
  end

  after_initialize do
    binding.pry
    self.event_type = event_type
    self.payload ||= {}
  end

  def self.payload_attributes(*attributes)
    @payload_attributes ||= []

    attributes.map(&:to_s).each do |attribute|
      @payload_attributes << attribute unless @payload_attributes.include?(attribute)

      define_method attribute do
        self.payload ||= {}
        self.payload[attribute]
      end

      define_method "#{attribute}=" do |argument|
        self.payload ||= {}
        self.payload[attribute] = argument
      end
    end

    @payload_attributes
  end

  def aggregate=(model)
    public_send("#{aggregate_name}=", model)
  end

  def aggregate
    public_send(aggregate_name)
  end

  def aggregate_id=(id)
    public_send "#{aggregate_name}_id=", id
  end

  def aggregate_id
    public_send "#{aggregate_name}_id"
  end

  def self.aggregate_name
    @aggregate_name||= begin
      inferred_aggregate = reflect_on_all_associations(:belongs_to).first
      raise "Events must belong to an aggregate" if inferred_aggregate.nil?
      inferred_aggregate.name
    end
  end

  def event_klass
    klass = self.class.to_s.split("::")
    klass[-1] = event_type
    klass.join('::').constantize
  end

  private

  def apply_and_persist
    # Lock the database row! (OK because we're in an ActiveRecord callback chain transaction)
    aggregate.lock! if aggregate.persisted?

    # Apply!
    binding.pry
    self.aggregate = apply(aggregate)

    #Persist!
    aggregate.save!
    self.aggregate_id = aggregate.id if aggregate_id.nil?
  end
  
  def find_or_build_aggregate
    binding.pry
    self.aggregate = find_aggregate if aggregate_id.present?
    self.aggregate = build_aggregate if self.aggregate.nil?
  end

  def find_aggregate
    klass = aggregate_name.to_s.classify.constantize
    klass.find(aggregate_id)
  end

  def build_aggregate
    public_send "build_#{aggregate_name}"
  end


  def event_type
    self.attributes["event_type"] || self.class.to_s.split("::").last
  end
end