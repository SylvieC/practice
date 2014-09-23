require 'rails_helper'
require 'spec_helper'


RSpec.describe UsersController, :type => :controller do

  # it "allows authenticated access" do
  #   sign_in

  #   get :index

  #   response.should be_success
  # end

describe User do

  # before(:each) { @user = User.new(email: 'user@example.com') }

  # subject { @user }

  # it { is_expected.to be_valid }

end

 
  it 'user should create an instance' 
    # sign_in 
    # @user.should be_an_instance_of(User)

  
  

#   describe "GET /users/@user.id/games" do
#   it "test access to games, works with a signed in user" do
#     sign_in_as_a_valid_user
#     get user_games_path(@user.id)
#     response.status.should be(200)
#   end
# end

# describe "GET /things" do
#   it "test access to things, does not work without a signed in user" do
#     get things_path
#     response.status.should be(302) # redirect to sign in page
#   end
# end


 
   describe 'find_target_frame_and_turn' do
    it 'after a first roll less than 10, it returns the same frame and 2'
    it 'after a second roll in a frame other than last frame, it returns the next frame and 1'
    it 'in frame 10, after a first roll less than 10 it returns frame 10 and 2'
    it 'in frame 10, after a first roll of 10, it returns frame 10 and 2'
    it 'in frame 10, if first roll is 10, after the second roll is played, it returns frame 10 and 3'
    it 'in frame 10, if the sum of first roll and second roll is 10, it returns frame 10 and 3'
    it 'in frame 10, after a second roll, if the sum of first roll and second roll is not 10 and first roll is not a strike, it returns 0 0 '
 end
   
   describe 'game_completed'do
     it 'returns true after roll 2 is played in frame 10 and no strike or spare have been played'
     it 'returns false after roll 2 is payed in frame 10 and a strike or a spare have been played'
     it 'returns true after turn 3 in frame 10 if there was a strike or a spare in the frame'
 end

   describe 'update_game' do
     it 'updates the attribute of a game is game_completed(game) is true'
     it "doesn't change the attribute is_completed of game if game_completed(game) is false"
  end

   describe 'build_scores_array'do
     it 'returns the score array properly if the rolls are normal'
     it 'returns the array properly if the roll is a strike'
     it 'returns the array properly with spares and strikes'
     it 'returns all the scores properly when there is a mixture'
 end

  describe 'final_scores' do
    it 'for all strikes, the total score is 300'
    it 'displays the proper value when no strikes or spares'
    it 'displays the proper values'
  end
end


#  find_target_frame_and_turn(game)
#       ordered_frames = game.frames.sort! { |a,b| a.num <=> b.num}
#       ordered_frames.each do |frame|
#         if frame.turn1.nil?
#           return [frame, 1]
#         elsif !frame.turn1.nil? && frame.turn2.nil? 
#             return [frame, 2]
#         elsif frame.num == 10 && (frame.category == 'spare' || frame.category == 'strike')
#            return [frame, 3]
#         end
#       end
#         return [0,0]  
#      end 
   

#     def build_scores_array(game)
#        frames = game.frames.sort! { |a,b| a.num <=> b.num }
#        result_array = []
#        frames.each_with_index do |frame,index|
#          result_array[index] = [frame.turn1, frame.turn2]
#       end
#       result_array[9].push(frames[9].turn3)
#       return result_array
#     end
   
#     def build_category_array(game)
#       frames = game.frames.sort! { |a,b| a.num <=> b.num}
      
#       categories =  frames. map do |frame|
#        frame.category
#       end
#     end
#  #categories is an array of the categories of the frames in the game
#     def final_result_array(categories, scores)
#       result = [ nil, nil,nil,nil,nil,nil,nil,nil,nil,nil]
#       #first step, check frame 10
#       #if turn1 and turn2 are not nil and frame's category is normal
#       #if turn2 and turn2 and turn3 are not nil and frame's category is not normal
#       if !scores[9].include?(nil) && categories[9] == 'normal'
#         result[9] = scores[9][0] + scores[9][1]
#       elsif categories[9] != 'normal' && !scores[9].include?(nil)
#         result[9] = scores[9].inject {|sum,x| sum + x}
#       end

#       #iterate again through array of score until the before last element and calculate all the normal frames
#      for i in 0..8
#          if !scores[i].include?(nil) && categories[i] == 'normal'
#           result[i] = scores[i][0] + scores[i][1]
#          end
#       end
#       # now we go through the array starting from end and update the frames we can update
      
#           #if we have a result array with no nil values and the frame is in the 'strike' category , we grab the value frame's values that is already calculated
#           # (which would mean that the value in result corresponding to the index of the next frame is not nil)
#           # I decided to iterate through the array in descending order so I can update values 
#           i = 9 
#       while i >= 1
#         if categories[i-1] == 'strike' && !result[i].nil?
#           result[i-1] = [10 + result[i], 30].min
#         elsif categories[i-1] == 'spare' && !scores[i][0].nil?
#           result[i-1] = 10 + scores[i][0]
#         end
#         i = i - 1
#       end
#           i = 9 
#       while i >= 1
#         if categories[i-1] == 'strike' && !result[i].nil?
#           result[i-1] = [10 + result[i], 30].min
#         elsif categories[i-1] == 'spare' && !scores[i][0].nil?
#           result[i-1] = 10 + scores[i][0]
#         end
#         i = i - 1
#       end
      
#       return result
#   end

#   def final_scores(game)
#     categories = build_category_array(game)
#     scores = build_scores_array(game)
#     return final_result_array(categories,scores)
#   end

#   def game_completed(game)
#       return f!inal_scores(game).include?(nil)
#   end
 #   def update_game(game)
  #    end

# def score_at(game,frame_num)
#   result = final_scores(game)
#   if result[frame_num -1].nil?
#     return nil
#   else
#     stop = frame_num - 1
#     array = result[0..stop]
#     sum = array.inject { |sum, ele| sum + ele}
#     return sum
#    end
    
# end

# def array_scores_at(game)
#   result_array = final_scores(game)
#   array_of_total_score_at_frame= []
#   for i in 0..9
#       array_of_total_score_at_frame[i] = score_at(game, i+1)

#   end
#   return array_of_total_score_at_frame
# end


# end

