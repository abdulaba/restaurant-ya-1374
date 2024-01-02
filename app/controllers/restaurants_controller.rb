class RestaurantsController < ApplicationController
  def index
    if params[:query].present?
      @restaurants = Restaurant.search_info_rest(params[:query])
    else  
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @markers = [
      {
        lat: @restaurant.latitude,
        lng: @restaurant.longitude
      }
    ]

  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save 
      redirect_to restaurants_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  def my_restaurants
    @restaurants = Restaurant.where(user_id: current_user.id)
  end

  private 
  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :address, :photo)
  end
end
