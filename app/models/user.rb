class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :todo_lists, :dependent => :destroy
  validates :email, format: { with: /\A.+@.+\z/ }, uniqueness: true
end
