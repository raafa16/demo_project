class AddPublishedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :published, :boolean, default:  false
  end
end
