class CommentsController < ApplicationController
 before_filter :authenticate_user!


 def index
    @comments = Comment.all 
 end

  def new
    @comment = Comment.new
    redirect_to user_dashboard_path(current_user.id)
  end

  def create
    new_comment = params.require(:comment).permit(:body, :game_id)
    @comment = Comment.create(new_comment)
    id = current_user.id

    respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @comment}
    end
   
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    update_params = params.require(:comment).permit(:body, :game_id) 
    @comment.update_attributes(update_params)
      respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @comment}
    end
  end

  def show
       @comment = Comment.find(params[:id])
       respond_to do |format|
      format.html {redirect_to user_dashboard_path(current_user.id)}
      format.json {render json: @game}
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to user_dashboard_path(current_user.id)
  end



end

