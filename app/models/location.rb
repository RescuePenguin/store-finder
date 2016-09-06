class Location < ApplicationRecord
  belongs_to :company, inverse_of: :locations

  reverse_geocoded_by :latitude, :longitude, location: :address
  after_validation :reverse_geocode
end
