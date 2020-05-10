class RenamePasswordDigestColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :password_digest, :password_digest
  end
end
