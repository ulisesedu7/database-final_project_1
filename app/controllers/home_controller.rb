class HomeController < ApplicationController
  # Skip the before_action :authenticate_user! for the home page
  skip_before_action :authenticate_user!, only: %i[ index ]
  skip_before_action :set_user_id_at_database
  skip_after_action :unset_user_id_at_database

  # GET /
  def index
    # Render the home page
    render "index"
  end

  # Reports page
  # GET /reports
  def reports
    @report_type = params[:report_type]
    @report_title = ''
    case @report_type
    when 'sales_by_agent'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM sales_count_by_agent")
      @report_title = 'Ventas por agente'
    when 'sales_by_seller'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM sales_count_by_seller")
      @report_title = 'Ventas por vendedor'
    when 'purchases_by_buyer'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM bought_count_by_buyer")
      @report_title = 'Compras por comprador'
    when 'sold_properties_by_city'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM sold_properties_by_city")
      @report_title = 'Propiedades vendidas por ciudad'
    when 'sold_properties_by_sale_price'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM sold_properties_by_sale_price")
      @report_title = 'Propiedades vendidas por precio de venta'
    when 'sold_properties_by_characteristics'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM sold_properties_by_characteristics")
      @report_title = 'Propiedades vendidas por características'
    when 'top_agent_by_sales_value'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM top_agent_by_sales_value")
      @report_title = 'Agente con mayor valor de ventas'
    when 'avg_sale_price_and_time_on_market_by_agent'
      @results = ActiveRecord::Base.connection.execute("SELECT * FROM avg_sale_price_and_time_on_market_by_agent")
      @report_title = 'Precio promedio de venta y tiempo en el mercado por agente'
    else
      @results = []
    end
  end

  # Audit logs page
  # GET /audit_logs
  def audit_logs
    @audit_logs = AuditLog.all
  end
end
