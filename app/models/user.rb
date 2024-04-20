class User < ApplicationRecord
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    [] # No associations for now
  end
end
