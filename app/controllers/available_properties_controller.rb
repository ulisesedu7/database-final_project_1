class AvailablePropertiesController < ApplicationController
  before_action :set_available_property, only: %i[ show edit update destroy ]
  before_action :set_agents_and_sellers, only: %i[ new edit update ]
  load_and_authorize_resource except: [:create]

  # Skip the before_action :authenticate_user! for the home page
  skip_before_action :authenticate_user!, only: %i[ index show ]

  # GET /available_properties or /available_properties.json
  def index
    @available_properties = AvailableProperty.all
  end

  # GET /available_properties/1 or /available_properties/1.json
  def show
    # Redirect to the available properties index page
    redirect_to available_properties_url
  end

  # GET /available_properties/new
  def new
    @available_property = AvailableProperty.new

    # If none of the agents or sellers exist, redirect to the index page displaying a message
    if @agents.empty? || @sellers.empty?
      redirect_to available_properties_url, alert: "No se puede crear una propiedad disponible sin agentes o vendedores"
    end
  end

  # GET /available_properties/1/edit
  def edit
    # If none of the agents or sellers exist, redirect to the index page displaying a message
    if @agents.empty? || @sellers.empty?
      redirect_to available_properties_url, alert: "No se puede crear una propiedad disponible sin agentes o vendedores"
    end
  end

  # POST /available_properties or /available_properties.json
  def create
    # Initialize a new AvailableProperty from params excluding :image
    @available_property = AvailableProperty.new(available_property_params.except(:image))

  if @available_property.save
    @available_property.image.attach(available_property_params[:image]) if available_property_params[:image].present?

    redirect_to available_properties_url, notice: "Propiedad disponible creada exitosamente."
  else
    redirect_to new_available_property_url, alert: "Error al crear una propiedad disponible"
  end

    # If the stored procedure fails, rescue the exception and redirect to the new available property page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to new_available_property_url, alert: "Error al crear una propiedad disponible"
  end

  # PATCH/PUT /available_properties/1 or /available_properties/1.json
  def update
    @available_property.assign_attributes(available_property_params.except(:image))

    if @available_property.save
      @available_property.image.attach(available_property_params[:image]) if available_property_params[:image].present?

      redirect_to available_properties_url, notice: "Propiedad disponible actualizada exitosamente."
    else
      render :edit, status: :unprocessable_entity, alert: "Error al actualizar una propiedad disponible"
    end

  # If the stored procedure fails, rescue the exception and redirect to the edit available property page
  rescue ActiveRecord::StatementInvalid => e
    render :edit, status: :unprocessable_entity, alert: "Error al actualizar una propiedad disponible"
  end

  # DELETE /available_properties/1 or /available_properties/1.json
  def destroy
    # Purge the attached image if any
    @available_property.image.purge if @available_property.image.attached?

    # Call your stored procedure for delete here
    ActiveRecord::Base.connection.execute("CALL delete_available_property(#{params[:id]});")

    # Redirect to the available properties index page
    redirect_to available_properties_url, notice: "Propiedad disponible eliminada exitosamente."

  # If the stored procedure fails, rescue the exception and redirect to the available properties index page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to available_properties_url, alert: "Error al eliminar una propiedad disponible"
  end

  private

  def set_available_property
    @available_property = AvailableProperty.find(params[:id])
  end

  def set_agents_and_sellers
    @agents = Agent.all
    @sellers = Seller.all
  end

  # Only allow a list of trusted parameters through.
  def available_property_params
    params.require(:available_property).permit(:name, :city, :address, :listed_price, :bedrooms, :has_pool, :publication_date, :image, :agent_id, :seller_id)
  end

  # Create the available property by agent relationship
  def create_available_property_by_agent(agent_id, property_id)
    AvailablePropertiesByAgent.create(agent_id: agent_id, available_property_id: property_id)
  end
end
