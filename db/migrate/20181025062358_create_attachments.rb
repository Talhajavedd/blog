require_relative '20181024130530_add_avatar_columns_to_users'

class CreateAttachments < ActiveRecord::Migration
  def change
  	revert AddAvatarColumnsToUsers
    create_table :attachments do |t|
      t.attachment :avatar
      t.references :attachable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
