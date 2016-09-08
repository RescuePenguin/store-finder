# App/controllers/companies_controller
class CompaniesController < ApplicationController
  require 'csv'

  # This will end up being our root path.
  def new
    @company = Company.new
  end

  def create
    # initialize our new company
    @company = Company.new
    # Make sure that a file was uploaded and not bypassed somehow
    if params[:company][:upload].nil?
      flash[:alert] = 'Please upload a .tsv file'
      return redirect_to new_company_path
    # Make sure that the file uploaded is a .tsv
    # TODO: Add more file types that are compatible with this type of information. Like csv's
    elsif !['.tsv'].include? File.extname(params[:company][:upload].tempfile)
      flash[:alert] = 'Please upload a .tsv file'
      return redirect_to new_company_path
    end
    # Use the CSV library to parse our file.
    parsed_file = CSV.read params[:company][:upload].tempfile, col_sep: "\t", headers: true, header_converters: :symbol
    # Build our locations based on information given in the file. Uses the headers to determine which information is saved where
    @company.locations.build parsed_file.map(&:to_hash)

    # If save is successful set up the background process for geocoding all of our new locations then redirect them to view them.
    if @company.save
      GeocoderWorker.perform_async(@company.locations.map(&:id)) if @company.locations.present?
      redirect_to @company
    # When we save, if information is incorrect return them to where they came to try again.
    else
      flash[:alert] = 'An error occurred while uploading the file, please try again later.'
      redirect_to new_company_path
    end
  end

  def index
    # display all of the currently made companies and paginate to prevent extraordinarily long load times if database grows.
    @companies = Company.all.page(params[:page]).per(25)
  end

  def show
    # grab all necessary information for the page before rendering
    @company = Company.find params[:id]
    search = params[:search].present? ? Geocoder.search(params[:search])[0] : Geocoder.search([33.1243208, -117.32582479999996])[0]
    @radius = params[:radius].present? ? params[:radius] : 25
    @latitude =  search.latitude
    @longitude = search.longitude
    @locations = @company.locations.near([@latitude, @longitude], @radius).page(params[:page]).per(50)
  end
end
