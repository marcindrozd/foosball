class AddMatchDateToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :match_date, :datetime
  end
end
