class UsersController < ApplicationController
  before_filter :authenticate_user!
  def dashboard
    @user = current_user
    if !current_user.games.empty?
        @game = current_user.games.last
        gon.user = current_user
        gon.game = @game
    end
  

    
   if !@game.nil?  && !@game.frames.empty?
      @frames = current_user.games.last.frames.sort! { |a,b| a.num <=> b.num}
      gon.target_frame = find_target_frame_and_turn(@game)[0]
      gon.target_turn = find_target_frame_and_turn(@game)[1]
      gon.frames = @frames
      # gon.answer = calculate_score(@game, @frames[0])
      # @scores = []
      # @frames.each do |frame|
      #    result = calculate_score(@game, frame)
      #   if !result.nil?
      #      @scores <<  result
      #   end
      # end
      # gon.scores = @scores
      
      @scores = build_scores_array(@game)
      @result = final_scores(@game)
      gon.scores = @scores

      @array_score_at_frames = array_scores_at(@game) 
      @categories = build_category_array(@game)  

     
      # @total = @result.inject { |sum,x| sum + x }
      # @result = final_result_array(@game,@scores)
      # gon.result = @result
 

    end
  end

  private

    def find_target_frame_and_turn(game)
      ordered_frames = game.frames.sort! { |a,b| a.num <=> b.num}
      ordered_frames.each do |frame|
        if frame.turn1.nil?
          return [frame, 1]
        elsif !frame.turn1.nil? && frame.turn2.nil? 
            return [frame, 2]
        elsif frame.num == 10 && (frame.category == 'spare' || frame.category == 'strike')
           return [frame, 3]
        end
      end
        return [ordered_frames[9],0]  
     end 
   

    def build_scores_array(game)
       frames = game.frames.sort! { |a,b| a.num <=> b.num }
       result_array = []
       frames.each_with_index do |frame,index|
         result_array[index] = [frame.turn1, frame.turn2]
      end
      result_array[9].push(frames[9].turn3)
      return result_array
    end
   
    def build_category_array(game)
      frames = game.frames.sort! { |a,b| a.num <=> b.num}
      
      categories =  frames. map do |frame|
       frame.category
      end
    end
 #categories is an array of the categories of the frames in the game
    def final_result_array(categories, scores)
      result = [ nil, nil,nil,nil,nil,nil,nil,nil,nil,nil]
      #first step, check frame 10
      #if turn1 and turn2 are not nil and frame's category is normal
      #if turn2 and turn2 and turn3 are not nil and frame's category is not normal
      if !scores[9][1].nil? && categories[9] == 'normal'
        result[9] = scores[9][0] + scores[9][1]
      elsif categories[9] != 'normal' && !scores[9].include?(nil)
        result[9] = scores[9].inject {|sum,x| sum + x}
      end

      #iterate again through array of score until the before last element and calculate all the normal frames
     for i in 0..8
         if !scores[i].include?(nil) && categories[i] == 'normal'
          result[i] = scores[i][0] + scores[i][1]
         end
      end
      # now we go through the array starting from end and update the frames we can update
      
          #if we have a result array with no nil values and the frame is in the 'strike' category , we grab the value frame's values that is already calculated
          # (which would mean that the value in result corresponding to the index of the next frame is not nil)
          # I decided to iterate through the array in descending order so I can update values 
          i = 9 
      while i >= 1
        if categories[i-1] == 'strike' && !result[i].nil?
          result[i-1] = [10 + result[i], 30].min
        elsif categories[i-1] == 'spare' && !scores[i][0].nil?
          result[i-1] = 10 + scores[i][0]
        end
        i = i - 1
      end
          i = 9 
      while i >= 1
        if categories[i-1] == 'strike' && !result[i].nil?
          result[i-1] = [10 + result[i], 30].min
        elsif categories[i-1] == 'spare' && !scores[i][0].nil?
          result[i-1] = 10 + scores[i][0]
        end
        i = i - 1
      end
      
      return result
  end

  def final_scores(game)
    categories = build_category_array(game)
    scores = build_scores_array(game)
    return final_result_array(categories,scores)
  end

  def game_completed(game)
      return final_scores(game).include?(nil)
  end

def score_at(game,frame_num)
  result = final_scores(game)
  if result[frame_num -1].nil?
    return nil
  else
    stop = frame_num - 1
    array = result[0..stop]
    sum = array.inject { |sum, ele| sum + ele}
    return sum
   end
    
end

def update_game(game)
  game.is_completed = true;
end

def array_scores_at(game)
  result_array = final_scores(game)
  array_of_total_score_at_frame= []
  for i in 0..9
      array_of_total_score_at_frame[i] = score_at(game, i+1)

  end
  return array_of_total_score_at_frame
end


end