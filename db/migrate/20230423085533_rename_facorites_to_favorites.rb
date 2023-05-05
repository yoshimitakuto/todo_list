class RenameFacoritesToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_table :facorites, :favorites
  end
end
