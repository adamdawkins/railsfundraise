class User < ApplicationRecord
  has_secure_password

  has_many :campaigns

  def first_name
    self.full_name.split(' ').first
  end
end
