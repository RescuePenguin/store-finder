#app/workers/GeocoderWorker.rb

class GeocoderWorker
  include Sidekiq::Worker

  def perform(location_ids)
    location_ids.each do |id|
      object = Location.find(id)
      coordinates = Geocoder.search(object.full_address)
      object.latitude = coordinates[0]
      object.longitude = coordinates[1]
      object.save!
    end
  end
end
