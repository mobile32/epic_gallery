class CreateTagsWithConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :galleries_tags do |t|
      t.belongs_to :galleries, index: true
      t.belongs_to :tags, index: true
    end

    create_table :images_tags do |t|
      t.belongs_to :images, index: true
      t.belongs_to :tags, index: true
    end
  end
end
