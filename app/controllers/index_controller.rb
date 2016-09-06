class IndexController < ApplicationController
  def index
    @company = Company.new
  end
end
