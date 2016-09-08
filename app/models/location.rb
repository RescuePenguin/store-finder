class Location < ApplicationRecord
  belongs_to :company, inverse_of: :locations

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    address_1 + address_2 + postal_code_name.to_s + postal_code_suffix.to_s
  end
end
