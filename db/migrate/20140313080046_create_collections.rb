class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :user, index: true
      t.references :idea, index: true

      t.timestamps
    end
  end
end
