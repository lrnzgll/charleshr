class Events::Holiday::Created < Events::Holiday::BaseEvent

  payload_attributes :date, :user, :created_by, :modified_by, :deleted

  def apply(holiday)
    holiday.date = date
    holiday.user_id = user
    holiday.created_by_id = created_by
    holiday.modified_by_id = modified_by
    holiday.deleted = deleted
  
    holiday
  end
end