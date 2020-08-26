class CreateHolidayEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :holiday_events do |t|
      t.belongs_to :holiday, null: false, foreign_key: true
      t.string :event_type
      t.json :payload

      t.timestamps
    end
  end
end
