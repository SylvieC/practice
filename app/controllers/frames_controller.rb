class FramesController < ApplicationController
 before_filter :authenticate_user!

 def index
    @frames = Frame.all
 end

 def edit
   @frame = Frame.find(params[:id])
end

def new
    @frame = Frame.new
    # redirect_to user_dashboard_path(current_user.id)
 end

  def create
    new_frame = params.require(:frame).permit(:turn1,:turn2,:turn3,:category,:num, :score)
    @frame = Frame.create(new_frame)

    respond_to do |format|
      format.html
      format.json {render json: @frame}
    end
  end

  def show
    @frame = Frame.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @frame}
    end
     redirect_to user_dashboard_path(current_user.id)
  end

  def update
    @frame = Frame.find(params[:id])
    @frame.update_attributes(params.require(:frame).permit(:turn1,:turn2, :turn3,:category,:num, :score))
    #@frame.game.frames.sort_by {|game| game.created_at}
    respond_to do |format|
      format.html
      format.json {render json: @frame}
    end
  end

end
