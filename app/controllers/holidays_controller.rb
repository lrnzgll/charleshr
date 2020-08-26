class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:edit]

  def index
    @holidays = current_user.holidays.includes(:creator, :modifier).order(:date)
  end

  def create
    Events::Holiday::Created.create(payload: holiday_params)
  end

  def edit; end

  def update
    binding.pry
    Events::Holiday::Updated.create(payload: holiday_params.merge(modified_by: current_user.id))
  end

  private

  def set_holiday
    @holiday = Holiday.find(params[:id])
  end
 
  def holiday_params
    params.require(:holiday).permit(:date, :user, :created_by, :modified_by, :deleted, :id)
  end
end