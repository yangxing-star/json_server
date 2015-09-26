class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.string    :url
      t.string    :method
      t.text      :data
      t.string    :comment

      t.timestamps
    end
  end
end
