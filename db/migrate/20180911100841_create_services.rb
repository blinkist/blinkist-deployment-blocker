class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.boolean :blocked, default: false

      t.timestamps
    end
  end
end
