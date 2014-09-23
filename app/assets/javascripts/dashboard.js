
var frames = gon.frames;
var turn = gon.target_turn;
var steps_since_last_refresh = 0;
var frame = gon.target_frame;
var score_to_add;
var turnString;
// var result_scores = step5_array_scores_at_frame(frames);

// $(document).on('load', function(event){
//   event.preventDefault();
//   showKeysTurn1();
// }
window.onload = function() {
  updateKeyBoard();
  }

$(document).on('click', '.add_score', function(event) { 
  
  event.preventDefault();
   score_to_add = $(this).text();
    var data = updatedFrameData(score_to_add);
   
    updateData(data,frame, function(){
   // display the right values for spares and strikes
    target_element = $('#frame'+ frame.num + 'turn' + turn);
  
    if ((score_to_add == 'X' || score_to_add == 10) && frame.num != 10){
      score_to_add = 'X';
      target_element.html('-');
      $('#frame' + frame.num + 'turn1:first-child').css('opacity', '0');
      $('#frame' + frame.num + 'turn' + 2).html('X');
    }else{
      target_element.html(score_to_add);
    }


  //and then update my hash with the values I just got : 
      updateAllValues();
   //--> append the score to $('#box' + frame.num)
 
    
    
      add_scores_to_dom();
      if (turn == 0){
        alert('End of Game, Congratulions!')
          $('#box10').css('color', 'blue');
          $('#newGame').show();
          //update all the scores 
           var scores = step5_array_scores_at_frame(frames)
          var data = {};
          for (var i = 0 ; i < 10 ; i++){
          data.score = scores[i];
          updateData(data, frames[i], function(){
          });
         }
      }
    

      updateKeyBoard();

  

      
      //--- > check if game is finished
     // alert('done! next available position: frame_num: ' +  frame.num + ' turn: ' + turn );

  })

  
})

// out of main
  var updateData = function(data,frame,  callback){
    $.ajax({
      url: '/users/' + gon.user.id +'/games/' + gon.game.id + '/frames/' + frame.id + '.json',
      type: 'patch',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        frame: data
      }
    }).done(callback);
  };

  // var updateKeyBoard = function(value) {
  //    if (value < 10){
  //     $('#add_strike').hide();
  //    }
  //   for ( var i= 0; i <= 10; i++ ){
  //     // if(10 - i < value){
  //       if ( i > 10  - value ){
  //       //disable
  //       $('#key' + i).hide();
  //       }
  //     }
  //  }

 
  var gameIsFinished =  function(frames){
      if (frames[-1].turn2 != null && frames[9].category == 'normal'){
        return true;
      }else if (frames[9].category != 'normal' && frames[9].turn3 == null){

      }else{
        return false;
      }
    } 

 
  var updateAllValues = function(){
    if (score_to_add == 'X'){
       score_to_add == 10;
    }else if (score_to_add != '/'){
    score_to_add = parseInt(score_to_add);
   }
 
 
    if (turn == 1){
      if (frame.num != 10){
        if (score_to_add != 10 && score_to_add != 'X'){
          frames[frame.num - 1].turn1 = score_to_add;
          turn = 2
          // alert('in turn1 loop');
        }else{
          //is is a strike and we are not in frame 10
          frames[frame.num - 1].turn1 = 10;
          frames[frame.num - 1].turn2 = 0;
          frames[frame.num - 1].category = 'strike';
          frame = frames[frame.num];
          }

     }else{
        //framenum is 10 
        if (score_to_add == 'X' || score_to_add == 10){
          frames[frame.num - 1].turn1 = 10;
          frames[frame.num - 1].category = 'strike';
          turn = 2;
        }else {
          frames[frame.num - 1].turn1 = score_to_add;
          turn = 2
        }
       }

     }else if (turn == 2){
      if (frame.num != 10){
         if (score_to_add != '/' && (score_to_add + frames[frame.num - 1].turn1  )!= 10 ){
             frames[frame.num - 1].turn2 = score_to_add;
             frame = frames[frame.num];
             // alert ( 'in turn2 loop frame is now' + frame.num)
             turn = 1; 
          }else if (score_to_add == '/' || (score_to_add +frames[frame.num - 1].turn1  == 10)){
            //spare not in frame 10
             score_to_add = 10 - frames[frame.num - 1].turn1;
             frames[frame.num-1].turn2 = score_to_add;
             frames[frame.num -1].category = 'spare';
             frame = frames[frame.num];
             turn = 1;
           }else{
            frames[frame.num - 1].turn2 = score_to_add;
            frame = frames[frame.num];
            turn = 1;
           }
        
      
      }else{
        //frame 10
        if ((score_to_add == '/' || score_to_add + frames[frame.num - 1].turn1  == 10) && frames[frame.num - 1].category != 'strike'){
         score_to_add = 10 - frames[frame.num - 1].turn1;
         frames[frame.num-1].turn2 = score_to_add;
         frames[frame.num - 1].category = 'spare';
         turn = 3
         }else if ( score_to_add == 'X' || score_to_add == 10){
         frames[frame.num - 1].turn2 = 10;
         frames[frame.num - 1].category = 'strike';
         turn = 3;
       }else if( score_to_add != 10 && frames[frame.num - 1].category == 'strike'){
         frames[frame.num - 1].turn2 = score_to_add;
         turn = 3;
         }else{
        frames[frame.num - 1].turn2 = score_to_add;
        add_scores_to_dom();
        turn = 0;
        //end of game
        }
      }
    }else if (turn == 3){
      frames[frame.num-1].turn3 = score_to_add;
      turn = 0;
      //end of game
   }
}


 // get params for ajax call to update frame in database 
 var updatedFrameData = function(score_to_add){
   
  var updatedFrameData = {}
  if (score_to_add === 'X'){
        score_to_add = 10;
      }else if (score_to_add === "/"){
       score_to_add = 10 - frame.turn1;
      }

  if (turn ===  1){
        if (score_to_add == 10){
          updatedFrameData.turn1 = 10;
          updatedFrameData.category = 'strike';
      if(frame.num != 10){
          updatedFrameData.turn2 = 0;
         }
        }else {
          updatedFrameData.turn1 = score_to_add;
         }
  }else if (turn === 2){
       if (frame.num != 10){
          if ( score_to_add + frame.turn1 == 10){
             updatedFrameData.turn2 = score_to_add;
             updatedFrameData.category = 'spare';
           }else{
            updatedFrameData.turn2 = score_to_add;
          }
       }else{
        //we are in frame 10
         updatedFrameData.turn2 = score_to_add;
         if (frame.turn1 != 10 && (frame.turn1 + score_to_add == 10)){
          //in this case we have a spare, we want to also update the category to spare - the game continues
          updatedFrameData.category = 'spare';
          }else if (frame.turn1 != 10 && (frame.turn1 + score_to_add != 10) ){
          //in this case, we just end the game
         
          $('#anotherGame').show();
        }
      }

    }else if ( turn === 3){
      updatedFrameData.turn3 = score_to_add;
      // gon.scores.push( gon.target_frame.turn1 + gon.target_frame.turn2 + score_to_add);
  
      $('#anotherGame').show();
    } 
    return updatedFrameData; 
 }
 //a simple array with all the scores (a null value will be where no score has been entered)
//a simple array with all the scores (a null value will be where no score has been entered)
 var step1_scores_array = function(frames){
  var resultArray = [];
  for ( var i = 0; i < 10; i ++){
     resultArray.push([frames[i].turn1, frames[i].turn2])
  }
   if (frames[9].turn3 == 'X'){
    resultArray[9].push(10);
  }else if (frames[9] == '/'){
     resultArray[9].push(10 - frames[9].turn1 - frames[9].turn2);
  }else if(frames[9].turn3 != null){
    resultArray[9].push(frames[9].turn3);
  }
  return resultArray;
 }

 //array where each element is the category of the frame
 var step2_category_per_frame = function(frames){
   var categories = [];
   for (var i = 0; i < 10; i++){
    categories.push(frames[i].category);
   }
   return categories;
 }


 
 //this method returns an array , each element in the array is the score per frame ( not overall score up to the frame)
 var step3_scores_per_frame = function(frames){
   var individual_scores = step1_scores_array(frames);
   var categories = step2_category_per_frame(frames);
  
   var result = Array.apply(null, new Array(10));
   //first iterate throught the individual_scores array and get the scores for each indidual frame
      for (var i = 0 ; i < 10 ; i++){
        if (categories[i] == 'normal' && individual_scores[i].indexOf(null) == -1){
            result[i] = individual_scores[i][0] + individual_scores[i][1];
          }
        }
      

       //frame 10 is special so we take care of that first
        if((categories[9] == 'strike' || categories[9] == 'spare') &&  individual_scores[9].indexOf(null) == -1 ){
            result[9] = sum_array_elements(individual_scores[9]);
          }


        //I go through the array again twice starting from the end, so I can easily update what I can update, we do it twice
    
       for (var i = 9; i >= 1 ; i--){
        if (categories[i - 1] == 'strike' && result[i] != null){
           result[i-1] = Math.min( 30,  10 + result[i]);
          } else if (categories[i -1] == 'spare' && individual_scores[i][0] != null){
            result[i -1] = 10 + individual_scores[i][0];
          }
       }
 
     
        
     return result;

      }

  // Element at index i is the added score for frame i + 1
  var step4_added_score_at_frame= function(frames, frameIndex){
    var result = step3_scores_per_frame(frames);
     if (result[frameIndex] == null){
        return null;
      }else{
        var subArray = result.slice(0,frameIndex + 1);
         return sum_array_elements(subArray);
      }
    } 

    var step5_array_scores_at_frame = function(frames){
      var arr = [];
      for (var i = 0 ; i < 10; i++){
        arr.push(step4_added_score_at_frame(frames, i));
        }
      return arr;
    }   
 
 var sum_array_elements = function(arr){
  var total = 0;
   $.each(arr,function() {
                   total += this;
              });
   return total

 }

  var add_scores_to_dom = function(){
    var arr = step5_array_scores_at_frame(frames);
 for (var i = 0; i <= 9 ; i++){
  if (arr[i] != null){
   $('#box' + (i+1)).html(arr[i]);
   }
} 
} 



var showKeysTurn1 = function(){
  $('#add_spare').hide();
  $('#add_strike').show();
  for ( var i = 0 ; i <= 10; i++){
   $('#key' + i ).show();
  }
 } 

var showKeysTurn2 = function(){
  $('#add_spare').show();
  var value = frames[frame.num - 1].turn1;
  for (var i = 1; i <= 10; i++){
    if (i > (10 - value)){
      $('#key' + i).hide();
    }
  }
  if (value > 0){
    $('#add_strike').hide();
  }
} 

// var updateKeyBoard = function(){
//   if (turn == 2 && frame.num != 10){
//     showKeysTurn2();
//   }else if (turn == 1 && frame.num != 10) {
//     showKeysTurn1();
//   }else if ( turn == 2 && frame.num == 10){
//     if(frame.category == 'strike'){
//       showKeysTurn1();
//     }
//   }else if (frame.num == 10 && turn == 1){
//       showKeysTurn1();
//   }else if (frame.num == 10 && turn == 2){
//       showKeysTurn2();
//     }

//   }else if(turn == 3){
//     showKeysTurn1();
//   }else if (turn == 0){
//    $('.scorebox').hide();
//   }
// }

var updateKeyBoard = function(){
 if (turn == 1){
    showKeysTurn1();
 }else if (turn ==2 ){
       if(frame.num == 10 && frame.category == 'strike'){
        showKeysTurn1();
       }else if ( frame.num == 10 && frame.category == 'normal'){
        showKeysTurn2();
      }else if (frame.num != 10){
        showKeysTurn2()
      }
 }else if (turn ==3){
    showKeysTurn1();
  }else if (turn == 0){
   $('.scorebox').hide();
  

  }

 }