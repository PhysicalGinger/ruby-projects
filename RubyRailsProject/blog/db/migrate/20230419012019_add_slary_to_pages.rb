class AddSlaryToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :salary, :integer
  end
end
