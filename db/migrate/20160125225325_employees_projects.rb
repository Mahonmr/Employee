class EmployeesProjects < ActiveRecord::Migration
  def change
    create_table(:employees_projects) do |t|
      t.belongs_to :project, index: true
      t.belongs_to :employee, index: true

      t.timestamps()
    end
  end
  end
