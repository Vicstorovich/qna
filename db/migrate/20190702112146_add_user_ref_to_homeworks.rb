class AddUserRefToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_reference :homeworks, :user, foreign_key: true
    add_reference :homeworks, :course, foreign_key: true
  end
end
