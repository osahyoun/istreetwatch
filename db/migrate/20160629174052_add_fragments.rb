class AddFragments < ActiveRecord::Migration[5.0]
  def change

    create_table :fragments do |t|
      t.text :name
      t.text :content
      t.timestamps
    end

    add_index :fragments, :name

  end
end
