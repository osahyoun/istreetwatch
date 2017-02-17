class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.decimal :lat, {precision: 10, scale: 6 }
      t.decimal :lng, {precision: 10, scale: 6 }
      t.datetime :time
      t.string :address
      t.string :street
      t.string :house
      t.string :town
      t.text :description
      t.string :summary
      t.boolean :approved, default: false
      t.string :postcode
      t.string :country
      t.string :region
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
