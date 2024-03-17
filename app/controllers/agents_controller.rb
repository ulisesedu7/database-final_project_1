class AgentsController < ApplicationController
  before_action :set_agent, only: %i[ show edit update destroy ]
  load_and_authorize_resource except: [:create]

  # GET /agents or /agents.json
  def index
    @agents = Agent.all
  end

  # GET /agents/1 or /agents/1.json
  def show
  end

  # GET /agents/new
  def new
    @agent = Agent.new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents or /agents.json
  def create
    authorize! :create, @agent
    # Call the stored procedure for creating an agent
    ActiveRecord::Base.connection.execute(
      "CALL create_agent('#{agent_params[:name]}', '#{agent_params[:email]}', '#{agent_params[:contract_date]}', #{agent_params[:base_commission]});"
    )

    redirect_to agents_url, notice: "Agente creado exitosamente."

  # If the stored procedure fails, rescue the exception and redirect to the new agent page
  rescue ActiveRecord::StatementInvalid => e
    redirect_to new_agent_url, alert: "Error al crear un agente"
  end

  # PATCH/PUT /agents/1 or /agents/1.json
  def update
    # Call the stored procedure for updating an agent
    ActiveRecord::Base.connection.execute(
      "CALL update_agent(#{params[:id]}, '#{agent_params[:name]}', '#{agent_params[:email]}', '#{agent_params[:contract_date]}', #{agent_params[:base_commission]});"
    )

    redirect_to agent_url(@agent), notice: "Agente actualizado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    render :edit, status: :unprocessable_entity, alert: "Error al actualizar un agente"
  end

  # DELETE /agents/1 or /agents/1.json
  def destroy
    # Call the stored procedure for deleting an agent
    ActiveRecord::Base.connection.execute("CALL delete_agent(#{params[:id]});")

    redirect_to agents_url, notice: "Agente eliminado exitosamente."
  rescue ActiveRecord::StatementInvalid => e
    redirect_to agents_url, alert: "Error al eliminar un agente"
  end

  private

  def set_agent
    @agent = Agent.find(params[:id])
  end

  def agent_params
    params.require(:agent).permit(:name, :email, :contract_date, :base_commission)
  end
end
