require 'spec_helper'
include Devise::TestHelpers
# @request.env["devise.mapping"] = Devise.mappings[:games]

RSpec.describe GamesController, :type => :controller do
  # include Devise::TestHelpers

  # before (:each) do
  #   @user = FactoryGirl.create(:user)
  #   sign_in @user
  # end

  # describe "POST 'create'" do
  #   it "creates a new game" do
  #     expect {
  #       post :create
  #     }.to change(Game, :count).by(1)
  #   end
  # end




  before(:each) do
    @user  = FactoryGirl.build(:user)
    # @game = user.games.create(attributes_for(:game))
    let (:game) { create :game }
   

  end

   #  describe "POST 'create'" do
   #    # parameters = attributes_for(:game)
   #    post :create,  {:game => {is_completed: false}
   #    expect{assigns(:game)}.to be_a (Game)
   #    expect{assigns(:game)}.to be_persisted

   #  end
    
   #   it 'game is created with 10 frames'do
   #    game.frames.count.shoud eq(10)
   # end

  # describe "index action" do
  #   it " the game and users exist" do
  #     sign_in @user
  #     params = {"user_id"=>"@user.id"}
  #     get :index
  #     assigns[:game].should exist
  #   end
  # end

end


   