class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :nickname,      null: false
      t.string    :mobile,        null: false
      t.string    :password_hash

      t.timestamps
    end
  end
end