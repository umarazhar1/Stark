class AddColumnsToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :title, :string
    add_column :projects, :description, :text
  end
end
