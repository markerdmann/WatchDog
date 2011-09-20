class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :url
      t.string :css_selector
      t.string :api_key
      t.float :frequency
      t.boolean :extract_number
      t.float :threshold

      t.timestamps
    end
  end
end
