class AssociatesDojoSessionsToConfirmedUsers < ActiveRecord::Migration
  def self.up
		
		create_table :confirmations, :id=>false do |t|
			t.integer :dojo_session_id
			t.integer :user_id
		end
	
  end

  def self.down
		drop_table :confirmations
  end
end
