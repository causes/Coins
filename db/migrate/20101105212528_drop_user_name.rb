class DropUserName < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
  end

  def self.down
    add_column :users, :name
  end
end
