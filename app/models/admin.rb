class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,
  # :registerable, :recoverable, and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable
end
