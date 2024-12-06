class AddConsecutiveFailuresToSites < ActiveRecord::Migration[8.0]
  def change
    add_column :sites, :consecutive_failures, :integer, default: 0
  end
end
