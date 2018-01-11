class User < ApplicationRecord
  has_secure_password

  has_many :projects, foreign_key: :created_by
  validates :email,uniqueness: true
  validates_presence_of :email, :password_digest
end
