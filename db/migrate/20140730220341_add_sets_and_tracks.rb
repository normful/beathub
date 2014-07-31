class AddSetsAndTracks < ActiveRecord::Migration
  def change
    create_table :sets do |t|
      t.string :artist
      t.string :title
      t.string :filepath
      t.date :date_aired
      t.timestamps
    end

    create_table :tracks do |t|
      t.belongs_to :set
      t.string :artist
      t.string :title
      t.string :filepath
      t.integer :track_number
      t.timestamps
    end
  end
end
