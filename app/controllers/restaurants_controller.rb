class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "Restaurant deleted successfully"

    redirect_to '/restaurants'
  end


end
