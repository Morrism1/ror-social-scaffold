class CreateFriendshipInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :friendship_invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :receiver_id
      t.boolean :status, default: :false

      t.timestamps
    end
  end
end
