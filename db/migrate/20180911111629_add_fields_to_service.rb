class AddFieldsToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :short_name, :string
    add_column :services, :blocked_at, :timestamp
    add_column :services, :blocked_by, :string
  end
end
