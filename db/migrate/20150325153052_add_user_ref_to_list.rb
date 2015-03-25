class AddUserRefToList < ActiveRecord::Migration
  def change
  	add_reference(:lists, :user)
  end
end
