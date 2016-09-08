# Locations hold information for each store, including all geolocational information.
class Location < ApplicationRecord
  # Locations are asscoiated to each other through their parent company.
  belongs_to :company, inverse_of: :locations

  # Geocoding for accurate geolocational info.
  geocoded_by :full_address

  # Full address to combines all parts of the street address given by uploaded files.
  # Useful for making sure google apis are giving us the right location.
  def full_address
    (address_1.present? ? address_1 : '') + (address_2.present? ? address_2 : '') +
      (postal_code_name.present? ? postal_code_name.to_s : '') + (postal_code_suffix.present? ? postal_code_suffix.to_s : '')
  end
end
