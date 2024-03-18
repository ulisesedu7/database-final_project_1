class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[ show edit update destroy ]
  load_and_authorize_resource except: [:create]

  # GET /buyers or /buyers.json
  def index
    @buyers = Buyer.all
  end

  # GET /buyers/1 or /buyers/1.json
  def show
    # Redirect to the buyers index page
    redirect_to buyers_url
  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
  end

  # GET /buyers/1/edit
  def edit
  end

  # POST /buyers or /buyers.json
  def create
    authorize! :create, @buyer

    # Call the stored procedure for creating a buyer
    ActiveRecord::Base.connection.execute(
      "CALL create_buyer('#{buyer_params[:name]}', '#{buyer_params[:email]}');"
    )

    redirect_to buyers_url, notice: "Comprador creado exitosamente."

  # If the stored procedure fails, rescue the exception and redirect to the new buyer page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to new_buyer_url, alert: "Error al crear un comprador"
  end

  # PATCH/PUT /buyers/1 or /buyers/1.json
  def update
    # Call the stored procedure for updating a buyer
    ActiveRecord::Base.connection.execute(
      "CALL update_buyer(#{params[:id]}, '#{buyer_params[:name]}', '#{buyer_params[:email]}');"
    )

    redirect_to edit_buyer_url(@buyer), notice: "Comprador actualizado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    render :edit, status: :unprocessable_entity, alert: "Error al actualizar un comprador"
  end

  # DELETE /buyers/1 or /buyers/1.json
  def destroy
    # Call the stored procedure for deleting a buyer
    ActiveRecord::Base.connection.execute("CALL delete_buyer(#{params[:id]});")

    redirect_to buyers_url, notice: "Comprador eliminado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    redirect_to buyers_url, alert: "Error al eliminar un comprador"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buyer
      @buyer = Buyer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def buyer_params
      params.require(:buyer).permit(:name, :email)
    end
end
