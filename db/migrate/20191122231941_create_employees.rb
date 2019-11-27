class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
      create_table :employees do |t|
        t.string :first_name
        t.string :surname
        t.string :email
        t.string :password
        t.datetime :created_at
        t.datetime :updated_at
      end
   end
end
