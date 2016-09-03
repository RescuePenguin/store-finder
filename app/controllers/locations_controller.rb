class LocationsController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def location_params
    params.require(:location).permit(:address_1, :address_2, :postal_code, :postal_code_suffix, :latitude, :longitude)
  end
end
