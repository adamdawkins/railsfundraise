class User < ApplicationRecord
  has_many :campaigns

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def first_name
    full_name.split(' ').first
  end
end
