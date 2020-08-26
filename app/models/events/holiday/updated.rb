class Events::Holiday::Updated < Events::Holiday::BaseEvent

  payload_attributes :date, :user, :created_by, :modified_by, :deleted, :holiday_id

  def apply(holiday)
    holiday.date = date if date
    holiday.modified_by_id = modified_by
  
    holiday
  end
end