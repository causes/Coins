class CreateChips < ActiveRecord::Migration
  def self.up
    create_table :chips do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :chips
  end
end
