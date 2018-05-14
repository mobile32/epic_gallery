class Tags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end

    create_table :image_tags do |t|
      t.belongs_to :image, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true

      t.timestamps
    end
  end
end
