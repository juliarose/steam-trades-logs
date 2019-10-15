class CreateKeyValues < ActiveRecord::Migration[6.0]
  def change
    create_table :key_values do |t|
      t.float :value
      t.date :date

      t.timestamps
    end
  end
end
