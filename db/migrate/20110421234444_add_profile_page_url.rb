class AddProfilePageUrl < ActiveRecord::Migration
  def self.up
		add_column :users, :page_url, :string
  end

  def self.down
		remove_column :users, :page_url
  end
end
