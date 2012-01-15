class CreatePopularEntries < ActiveRecord::Migration
  def change
    create_table :popular_entries do |t|
      t.string :url
      t.string :title
      t.date :publish_date
      t.integer :year
      t.integer :month
      t.integer :bookmark_count, :default => 0

      t.timestamps
    end
  end
end
