class PlantsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # delete
  def destroy
    plant = find_plants
    plant.destroy
    head :no_content
  end

  # update
  def update
    plant = find_plants
    plant.update(plant_params)
    render json: plant
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end


  def find_plants
    Plant.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

end