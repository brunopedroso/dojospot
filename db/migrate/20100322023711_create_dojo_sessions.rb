class CreateDojoSessions < ActiveRecord::Migration
  def self.up
		create_table :dojo_sessions do |t|
			t.string :title
			t.string :text
			t.string :place
			t.date :date
			t.string :time
		end
	
  end

  def self.down
		drop_table :dojo_sessions
  end
end
