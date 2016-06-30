class CreatePledges < ActiveRecord::Migration[5.0]
  def change
    create_table :pledges do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
