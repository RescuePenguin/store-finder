# app/workers/GeocoderWorker.rb
class GeocoderWorker
  include Sidekiq::Worker

  # Worker to geocode our locations in the background. This significantly increases the speed of submitting a larger file.
  def perform(location_ids)
    location_ids.each do |id|
      object = Location.find(id)
      geo = Geocoder.search(object.full_address)
      object.latitude = geo[0].latitude
      object.longitude = geo[0].longitude
      object.address = geo[0].address
      object.save
    end
  end
end
