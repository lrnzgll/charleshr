class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:edit, :events]

  def index
    @holidays = current_user.holidays.includes(:creator, :modifier).order(:date)
  end

  def new
    @holiday = Holiday.new
  end

  def create
    Events::Holiday::Created.create(payload: holiday_params.merge(user: current_user.id,
                                                                  created_by: current_user.id))
    redirect_to holidays_path
  end

  def edit; end

  def update
    Events::Holiday::Updated.create(payload: holiday_params.merge(modified_by: current_user.id), holiday_id: params[:id])
    redirect_to holidays_path
  end

  def delete_request
    set_holiday
  end

  def destroy
    Events::Holiday::Deleted.create(payload: {}, holiday_id: params[:id])
    redirect_to holidays_path
  end

  def events
    @events = @holiday.events
  end

  private

  def set_holiday
    @holiday = Holiday.find(params[:id])
  end
 
  def holiday_params
    params.require(:holiday).permit(:date, :user, :deleted)
  end
end