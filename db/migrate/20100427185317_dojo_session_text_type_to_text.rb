class DojoSessionTextTypeToText < ActiveRecord::Migration

  def self.up	
		change_table :dojo_sessions do |t|
		  t.change :text, :text
		end
  end

  def self.down
		change_table :dojo_sessions do |t|
		  t.change :text, :string
		end
  end
end
