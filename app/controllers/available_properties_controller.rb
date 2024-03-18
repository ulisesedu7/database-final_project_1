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

    # Call your stored procedure here instead of save
    ActiveRecord::Base.connection.execute(
      "CALL create_available_property(
        '#{available_property_params[:name]}',
        '#{available_property_params[:city]}',
        '#{available_property_params[:address]}',
        #{available_property_params[:listed_price]},
        #{available_property_params[:bedrooms]},
        #{available_property_params[:has_pool] ? 'TRUE' : 'FALSE'},
        '#{available_property_params[:publication_date]}',
        #{available_property_params[:agent_id]},
        #{available_property_params[:seller_id]}
      );"
    )

    # If the record is saved successfully and there's an image, attach it
    # First find the persisted record and then attach the image
    if available_property_params[:image].present?
      @new_available_property = AvailableProperty.find_by(name: available_property_params[:name], city: available_property_params[:city], address: available_property_params[:address], listed_price: available_property_params[:listed_price], bedrooms: available_property_params[:bedrooms], has_pool: available_property_params[:has_pool], publication_date: available_property_params[:publication_date], agent_id: available_property_params[:agent_id], seller_id: available_property_params[:seller_id])

      @new_available_property.image.attach(available_property_params[:image])
    end

    # Redirect to the available properties index page
    redirect_to available_properties_url, notice: "Propiedad disponible creada exitosamente."

    # If the stored procedure fails, rescue the exception and redirect to the new available property page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to new_available_property_url, alert: "Error al crear una propiedad disponible"
  end

  # PATCH/PUT /available_properties/1 or /available_properties/1.json
  def update
    # Call your stored procedure for update here
    ActiveRecord::Base.connection.execute(
      "CALL update_available_property(
        #{params[:id]},
        '#{available_property_params[:name]}',
        '#{available_property_params[:city]}',
        '#{available_property_params[:address]}',
        #{available_property_params[:listed_price]},
        #{available_property_params[:bedrooms]},
        #{available_property_params[:has_pool] ? 'TRUE' : 'FALSE'},
        '#{available_property_params[:publication_date]}',
        #{available_property_params[:agent_id]},
        #{available_property_params[:seller_id]}
      );"
    )

    # If the record is saved successfully and there's an image, attach it
    # First find the persisted record and then attach the image
    if available_property_params[:image].present?
      @new_available_property = AvailableProperty.find_by(id: params[:id])

      # Remove the previous image if any
      @new_available_property.image.purge if @new_available_property.image.attached?

      @new_available_property.image.attach(available_property_params[:image])
    end

    # Create the available property by agent relationship
    create_available_property_by_agent(available_property_params[:agent_id], params[:id])

    redirect_to edit_available_property_url(@available_property), notice: "Propiedad disponible actualizada exitosamente."

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
