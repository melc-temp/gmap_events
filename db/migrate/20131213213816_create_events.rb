class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_start_date
      t.time :event_start_time
      t.date :event_end_date
      t.time :event_end_time
      t.string :event_desc
      t.string :text
      t.string :map_id
      t.string :integer

      t.timestamps
    end
  end
end
