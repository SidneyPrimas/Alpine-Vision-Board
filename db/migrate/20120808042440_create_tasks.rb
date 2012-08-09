class CreateTasks < ActiveRecord::Migration
  def change
    #create a table called tasks
    create_table :tasks do |t|
      #Create a field called tasks which is a string
      t.string :task

      t.timestamps
    end
  end
end
