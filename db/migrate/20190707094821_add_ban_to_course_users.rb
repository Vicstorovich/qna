class AddBanToCourseUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :course_users, :ban, :boolean, null: false, default: true
  end
end
