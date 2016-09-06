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
  end
end
