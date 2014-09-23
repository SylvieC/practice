class GamesController < ApplicationController
   before_filter :authenticate_user!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    new_user_id = current_user.id
    new_game = params.require(:game).permit(:is_completed,:frames_played)
    @game = current_user.games.create(new_game)
    #create 10 frames for this game
    for i in 1..10
      @game.frames.create(category: 'normal', num: i)
    end
    
    respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @game}
    end

  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(params.require(:game).permit(:is_completed, :frames_played))
    respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @game}
    end
  end

   def show
    @game = Game.find(params[:id])
    respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @game}
   end
   end

  def destroy
    game  = Game.find(params[:id])
    game.destroy
    redirect_to user_dashboard_path(current_user.id)
  end
end

  
