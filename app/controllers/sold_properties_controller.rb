class SoldPropertiesController < ApplicationController
  before_action :set_sold_property, only: %i[ show edit update destroy ]
  before_action :set_agents_and_sellers, only: %i[ new edit update ]
  load_and_authorize_resource except: [:create]

  # Skip the before_action :authenticate_user! for the home page
  skip_before_action :authenticate_user!, only: %i[ index show ]

  # GET /sold_properties or /sold_properties.json
  def index
    @sold_properties = SoldProperty.all
  end

  # GET /sold_properties/1 or /sold_properties/1.json
  def show
    # Redirect to the sold properties index page
    redirect_to sold_properties_url
  end

  # GET /sold_properties/new
  def new
    @sold_property = SoldProperty.new

    # If none of the agents or sellers exist, redirect to the index page displaying a message
    if @agents.empty? || @sellers.empty? || @buyers.empty?
      redirect_to sold_properties_url, alert: "No se puede crear una propiedad vendida sin agentes, vendedores o compradores"
    end
  end

  # GET /sold_properties/1/edit
  def edit
    # If none of the agents or sellers exist, redirect to the index page displaying a message
    if @agents.empty? || @sellers.empty? || @buyers.empty?
      redirect_to sold_properties_url, alert: "No se puede crear una propiedad vendida sin agentes, vendedores o compradores"
    end
  end

  # POST /sold_properties or /sold_properties.json
  def create
    # Initialize a new SoldProperty from params excluding :image
    @sold_property = SoldProperty.new(sold_property_params.except(:image))

    # Call your stored procedure here instead of save
    ActiveRecord::Base.connection.execute(
      "CALL create_sold_property(
        '#{sold_property_params[:name]}',
        '#{sold_property_params[:city]}',
        '#{sold_property_params[:address]}',
        #{sold_property_params[:sale_price]},
        #{sold_property_params[:bedrooms]},
        #{sold_property_params[:has_pool] ? 'TRUE' : 'FALSE'},
        '#{sold_property_params[:sale_date]}',
        #{sold_property_params[:agent_commission]},
        #{sold_property_params[:buyer_id]},
        #{sold_property_params[:seller_id]},
        #{sold_property_params[:agent_id]}
      );"
    )

    # If the record is saved successfully and there's an image, attach it
    if @sold_property.persisted? && sold_property_params[:image].present?
      @sold_property.image.attach(sold_property_params[:image])

      # Update the sold property with the attached image
      @sold_property.update(sold_property_params)
    end

    # Redirect to the sold properties index page
    redirect_to sold_properties_url, notice: "Propiedad vendida creada exitosamente."

    # If the store procedure fails, rescue the exception and redirect to the index page displaying a message
  rescue ActiveRecord::StatementInvalid => e
    redirect_to sold_properties_url, alert: "No se puede crear una propiedad vendida sin un comprador"
  end

  # PATCH/PUT /sold_properties/1 or /sold_properties/1.json
  def update
    # Call your stored procedure here instead of update
    ActiveRecord::Base.connection.execute(
      "CALL update_sold_property(
        #{params[:id]},
        '#{sold_property_params[:name]}',
        '#{sold_property_params[:city]}',
        '#{sold_property_params[:address]}',
        #{sold_property_params[:sale_price]},
        #{sold_property_params[:bedrooms]},
        #{sold_property_params[:has_pool] ? 'TRUE' : 'FALSE'},
        '#{sold_property_params[:sale_date]}',
        #{sold_property_params[:agent_commission]},
        #{sold_property_params[:buyer_id]},
        #{sold_property_params[:seller_id]},
        #{sold_property_params[:agent_id]}
      );"
    )

    # If the record is updated successfully and there's an image, attach it
    if @sold_property.update(sold_property_params) && sold_property_params[:image].present?
      @sold_property.image.attach(sold_property_params[:image])

      # Update the sold property with the attached image
      @sold_property.update(sold_property_params)
    end

    # Redirect to the sold properties index page
    redirect_to sold_properties_url, notice: "Propiedad vendida actualizada exitosamente."

    # If the store procedure fails, rescue the exception and redirect to the edit sold property page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to edit_sold_property_url(@sold_property), alert: "Error al actualizar la propiedad vendida"
  end

  # DELETE /sold_properties/1 or /sold_properties/1.json
  def destroy
    # Purge the attached image if any
    @sold_property.image.purge if @sold_property.image.attached?

    # Call your stored procedure for delete here
    ActiveRecord::Base.connection.execute(
      "CALL delete_sold_property(#{params[:id]});"
    )

    # Redirect to the sold properties index page
    redirect_to sold_properties_url, notice: "Propiedad vendida eliminada exitosamente."

    # If the store procedure fails, rescue the exception and redirect to the sold properties index page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to sold_properties_url, alert: "Error al eliminar la propiedad vendida"
  end

  private

  def set_sold_property
    @sold_property = SoldProperty.find(params[:id])
  end

  def set_agents_and_sellers
    @agents = Agent.all
    @sellers = Seller.all
    @buyers = Buyer.all
  end

  # Only allow a list of trusted parameters through.
  def sold_property_params
    params.require(:sold_property).permit(:name, :city, :address, :sale_price, :bedrooms, :has_pool, :sale_date, :buyer_id, :seller_id, :agent_id, :image, :agent_commission)
  end
end