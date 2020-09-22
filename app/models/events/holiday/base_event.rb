class Events::Holiday::BaseEvent < Events::BaseEvent
  self.table_name = "holiday_events"
  self.inheritance_column = :event_type
  
  belongs_to :holiday, class_name: "::Holiday"
end