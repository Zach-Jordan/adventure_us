class AboutPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at updated_at] # Add all searchable attributes here
  end
end
