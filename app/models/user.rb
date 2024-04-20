class User < ApplicationRecord
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /\A(?=.*[[:punct:]])(?=.*[[:lower:]])(?=.*[[:upper:]])(?=.*[0-9]).*\z/, message: "must contain at least one special character, one lowercase letter, one uppercase letter, and one digit" }

  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    [] # No associations for now
  end
end
