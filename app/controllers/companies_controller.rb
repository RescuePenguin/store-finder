class CompaniesController < ApplicationController
  require 'csv'

  def new
    @company = Company.new
  end

  def create
    @company = Company.new
    if params[:company][:upload].nil?
      flash[:alert] = 'Please upload a .tsv file'
      return redirect_to new_company_path
    elsif !['.tsv'].include? File.extname(params[:company][:upload].tempfile)
      flash[:alert] = 'Please upload a .tsv file'
      return redirect_to new_company_path
    end
    parsed_file = CSV.read params[:company][:upload].tempfile, col_sep: "\t", headers: true, header_converters: :symbol
    @company.locations.build parsed_file.map(&:to_hash)

    if @company.save
      GeocoderWorker.perform_async(@company.locations.map(&:id)) if @company.locations.present?
      redirect_to @company
    else
      redirect_to new_company_path
    end
  end

  def index
    @companies = Company.all.page(params[:page]).per(25)
  end

  def show
    @company = Company.find params[:id]
    default_loc = Geocoder.search([33.1243208, -117.32582479999996])[0]
    search = Geocoder.search(params[:search])[0] if params[:search].present?
    @radius = params[:radius].present? ? params[:radius] : 25
    @latitude =  params[:search].present? ? search.latitude : default_loc.latitude
    @longitude = params[:search].present? ? search.longitude : default_loc.longitude
    @locations = @company.locations.near([@latitude, @longitude], @radius).page(params[:page]).per(50)
  end
end
