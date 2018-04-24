class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image_file, null: false
      t.string :description
      t.string :localization

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
