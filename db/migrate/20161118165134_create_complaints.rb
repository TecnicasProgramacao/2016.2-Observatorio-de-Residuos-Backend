#Complaints
class CreateComplaints < ActiveRecord::Migration
  
  def change
    create_table :complaints do |t|
      t.string :title
      t.string :description
      t.string :author
      t.integer :id_marking

      t.timestamps null: false
    end
  end

end
