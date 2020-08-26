class Events::Holiday::BaseEvent < Events::BaseEvent
  self.table_name = "holiday_events"

  belongs_to :holiday, class_name: "::Holiday"
end