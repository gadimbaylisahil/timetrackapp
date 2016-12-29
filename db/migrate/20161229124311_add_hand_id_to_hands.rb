class AddHandIdToHands < ActiveRecord::Migration[5.0]
  def change
    add_column :hands, :hand_id, :integer
  end
end
