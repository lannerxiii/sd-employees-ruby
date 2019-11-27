class CreateEmployeeTypes < ActiveRecord::Migration[5.2]
  def change
      create_table :employee_types do |t|
          t.string :initials
          t.string :description
          t.datetime :created_at
          t.datetime :updated_at
      end
  end
end
