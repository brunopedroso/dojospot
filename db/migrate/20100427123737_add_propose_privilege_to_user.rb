class AddProposePrivilegeToUser < ActiveRecord::Migration

  def self.up
		add_column :users, :has_propose_priv, :boolean
  end

  def self.down
		remove_column :users, :has_propose_priv
  end

end
