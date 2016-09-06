class CompaniesController < ApplicationController
  require 'csv'

  def create
    @company = Company.new
    parsed_file = CSV.read params[:company][:upload].tempfile, col_sep: "\t", headers: true, header_converters: :symbol
    @company.locations.build parsed_file.map(&:to_hash)

    @company.save
    redirect_to @company
  end

  def index
  end

  def show
    @company = Company.find params[:id]
    search = Geocoder.search(params[:search]) if params[:search].present?
    default_loc = Geocoder.search([33.1243208, -117.32582479999996])[0]
    @radius = params[:radius].present? ? params[:radius] : 2000
    @latitude = search.present? ? search.latitude : default_loc.latitude
    @longitude = search.present? ? search.longitude : default_loc.longitude
    @locations = @company.locations.near([@latitude, @longitude], @radius)
  end
end
