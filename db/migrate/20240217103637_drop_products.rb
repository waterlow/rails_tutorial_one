require_relative '20231029044533_create_products'

class DropProducts < ActiveRecord::Migration[7.1]
  def change
    revert CreateProducts
  end
end
