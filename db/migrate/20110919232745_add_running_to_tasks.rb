class AddRunningToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :running, :boolean
  end
end
