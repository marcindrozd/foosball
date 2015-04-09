class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1_id, :player2_id, :score_player1, :score_player2

      t.timestamps
    end
  end
end
