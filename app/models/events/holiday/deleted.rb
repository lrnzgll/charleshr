class Events::Holiday::Deleted < Events::Holiday::BaseEvent

  payload_attributes :date, :user, :created_by, :modified_by, :deleted

  def apply(holiday)
    holiday.deleted = true
    holiday.modified_by_id = modified_by
  
    holiday
  end
end