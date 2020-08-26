class Holiday < ApplicationRecord
  belongs_to :user
  belongs_to :creator, class_name: 'User', foreign_key: "created_by_id"
  belongs_to :modifier, class_name: 'User', foreign_key: "modified_by_id", optional: true

  has_many :events, class_name: "Events::Holiday::BaseEvent"
end