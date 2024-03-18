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
    @sold_property = SoldProperty.new(sold_property_params.except(:image))

    if @sold_property.save
      @sold_property.image.attach(sold_property_params[:image]) if sold_property_params[:image].present?

      redirect_to sold_properties_url, notice: "Propiedad vendida creada exitosamente."
    else
      redirect_to new_sold_property_url, alert: "Error al crear una propiedad vendida"
    end

    # If the store procedure fails, rescue the exception and redirect to the index page displaying a message
  rescue ActiveRecord::StatementInvalid => e
    redirect_to sold_properties_url, alert: "Propiedad vendida no creada. Error en el servidor. Inténtelo de nuevo."
  end

  # PATCH/PUT /sold_properties/1 or /sold_properties/1.json
  def update
    @sold_property.assign_attributes(sold_property_params.except(:image))

    if @sold_property.save
      @sold_property.image.attach(sold_property_params[:image]) if sold_property_params[:image].present?

      redirect_to sold_properties_url, notice: "Propiedad vendida actualizada exitosamente."
    else
      redirect_to edit_sold_property_url(@sold_property), alert: "Error al actualizar la propiedad vendida"
    end

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
