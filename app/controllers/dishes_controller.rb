class DishesController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dish = Dish.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dish = Dish.new(dish_params)
    @dish.restaurant_id = @restaurant.id
    if @dish.save 
      redirect_to restaurant_path(@restaurant.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def dish_params 
    params.require(:dish).permit(:name, :description, :price, :photo)
  end
end
