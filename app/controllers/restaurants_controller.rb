class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # Authorization without pundit
  # before_action :validate_user, only: %i[edit update destroy]

  # GET /restaurants
  def index
    # @restaurants = Restaurant.all # without pundit
    @restaurants = policy_scope(Restaurant)
  end

  # GET /restaurants/1
  def show
    authorize(@restaurant)
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    authorize(@restaurant)
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize(@restaurant)
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize(@restaurant)
  end

  # Only allow a list of trusted parameters through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :user_id)
  end

  # Authorization without pundit
  # def validate_user
  #   if !current_user.admin? && @restaurant.user != current_user
  #     redirect_to root_path, alert: 'Invalid Action'
  #     return
  #   end
  # end
end
