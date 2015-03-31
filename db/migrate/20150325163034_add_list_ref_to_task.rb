class AddListRefToTask < ActiveRecord::Migration
  def change
    add_reference(:tasks, :list)
  end
end
