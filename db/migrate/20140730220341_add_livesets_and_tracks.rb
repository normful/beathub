class AddLivesetsAndTracks < ActiveRecord::Migration
  def change
    create_table :livesets do |t|
      t.string :artist
      t.string :title
      t.string :filepath
      t.string :cuepath
      t.string :zippath
      t.date :date_aired
      t.timestamps
    end

    create_table :tracks do |t|
      t.belongs_to :liveset
      t.string :artist
      t.string :title
      t.string :filepath
      t.integer :track_number
      t.integer :liveset_id_workaround
      t.timestamps
    end
  end
end
