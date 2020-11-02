class CreateFriendshipInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :friendship_invitations do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :status

      t.timestamps
    end
    add_foreign_key :friendship_invitations, :users, column: :friend_id
  end
end
