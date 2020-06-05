module SampleHelper
  def sales_chart_label(this_year_sales:, last_year_sales:)
    sales = this_year_sales.count >= last_year_sales.count ? this_year_sales : last_year_sales
    sales.map { |sale| sale.date.strftime('%b') }.to_json
  end
end
