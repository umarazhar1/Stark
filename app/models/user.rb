class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_users
  has_many :projects, through: :project_users

  has_many :bug_users
  has_many :bugs, through: :bug_users

  validates :username, presence: true
  validates :user_type, presence: true

  enum user_type: { developer: 0, manager: 1, qa: 2 }
end
