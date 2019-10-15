class CreateUsdValues < ActiveRecord::Migration[6.0]
  def change
    create_table :usd_values do |t|
      t.decimal :value
      t.date :date

      t.timestamps
    end
  end
end
