class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps

      t.check_constraint "length(name) > 0", name: "name_presence_check"
      t.check_constraint "length(email) > 0", name: "email_presence_check"
    end
  end
end
