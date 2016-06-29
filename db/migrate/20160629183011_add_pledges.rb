class AddPledges < ActiveRecord::Migration[5.0]
  def change
    create_table :pledges do |t|
      t.text :email
      t.text :name
      t.timestamps
    end
  end
end
