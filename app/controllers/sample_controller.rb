class SampleController < ApplicationController
  def index
    @this_year_sales = Sale.where(date: Time.current.all_year).order(:date)
    @last_year_sales = Sale.where(date: Time.current.years_ago(1).all_year).order(:date)
  end
end
