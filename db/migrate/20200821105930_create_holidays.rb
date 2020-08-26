class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.datetime :date
      t.references :created_by, null: false
      t.references :modified_by
      t.references :user, null: false, foreign_key: true
      t.boolean :deleted

      t.timestamps
    end
  end
end
