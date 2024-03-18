class SellersController < ApplicationController
  before_action :set_seller, only: %i[ show edit update destroy ]
  load_and_authorize_resource except: [:create]

  # GET /sellers or /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1 or /sellers/1.json
  def show
    # Redirect to the sellers index page
    redirect_to sellers_url
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers or /sellers.json
  def create
    authorize! :create, @seller

    # Call the stored procedure for creating a seller
    ActiveRecord::Base.connection.execute(
      "CALL create_seller('#{seller_params[:name]}', '#{seller_params[:email]}');"
    )

    redirect_to sellers_url, notice: "Vendedor creado exitosamente."

  # If the stored procedure fails, rescue the exception and redirect to the new seller page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to new_seller_url, alert: "Error al crear un vendedor"
  end

  # PATCH/PUT /sellers/1 or /sellers/1.json
  def update
    # Call the stored procedure for updating a seller
    ActiveRecord::Base.connection.execute(
      "CALL update_seller(#{params[:id]}, '#{seller_params[:name]}', '#{seller_params[:email]}');"
    )

    redirect_to edit_seller_url(@seller), notice: "Vendedor actualizado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    render :edit, status: :unprocessable_entity, alert: "Error al actualizar un vendedor"
  end

  # DELETE /sellers/1 or /sellers/1.json
  def destroy
    # Call the stored procedure for deleting a seller
    ActiveRecord::Base.connection.execute("CALL delete_seller(#{params[:id]});")

    redirect_to sellers_url, notice: "Vendedor eliminado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    redirect_to sellers_url, alert: "Error al eliminar un vendedor"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seller_params
      params.require(:seller).permit(:name, :email)
    end
end
