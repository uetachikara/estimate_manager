class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_many :clients, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
