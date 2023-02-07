class RenamePostCounterToPostsCounter < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :posts_counter, :posts_counter
  end
end