class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :nickname,      null: false
      t.string    :email,         null: false
      t.string    :locale,        null: false, default: 'en'
      t.string    :token,         null: false
      t.string    :password_hash

      t.timestamps
    end
  end
end