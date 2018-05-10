class Tags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end

    create_table :galleries_tags do |t|
      t.belongs_to :gallery, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
    end

    create_table :images_tags do |t|
      t.belongs_to :image, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
    end
  end
end
