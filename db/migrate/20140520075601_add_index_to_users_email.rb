class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique:true # per inserire un indice
  end
end
