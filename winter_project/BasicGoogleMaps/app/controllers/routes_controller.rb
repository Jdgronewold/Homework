class RoutesController < ApplicationController

  def create
    @route = Route.new(route_params)
    @route.user_id = current_user.id
    @route.save
    flash[:errors] = @route.errors.full_messages
    redirect_to user_url(@route.user_id)
  end

  def destroy
    route = Route.find(params[:id])
    route.destroy
    redirect_to user_url(route.user_id)
  end

  def show
    @user = User.find_by(username: params[:user][:username])
    @friend_routes = user.routes
    redirect_to user_url(current_user)
  end

  private

  def route_params
    params.require(:route).permit(:start_point, :end_point)
  end
end
