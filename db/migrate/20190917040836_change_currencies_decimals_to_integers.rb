class ChangeCurrenciesDecimalsToIntegers < ActiveRecord::Migration[6.0]
  def change
    change_column :usd_values, :value, :integer
    change_column :scm_values, :value, :integer
  end
end
