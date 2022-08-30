class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :invitee, foreign_key: { to_table: :users }
      t.references :inviter, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
