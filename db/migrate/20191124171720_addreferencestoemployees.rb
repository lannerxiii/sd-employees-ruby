class Addreferencestoemployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :employee_type, foreign_key:true
  end
end
