class Mastermind 
  
  $guess = [] 
  $feedback_array = [] 
  $round_nested_array = []
  # /\ both of these will be specific to each round 
  # they get reset to empty arrays at the end of each round. 
  # each guess will be stored in the initialized all_guess array for the entire game. 
  # maybe feedback should also be stored in an initialized array for the entire game. 

    def initialize
    @colors = ["green", "blue", "pink", "yellow", "orange"] 
    @generated_code = [] 
    @all_guesses = [] 
    end
    

  def generate_computer_code
    # use rand method to randomly generate code of four colors from array of colors 
   
    4.times do 
      random_num = rand(5) 
      selected_color = @colors[random_num]
      @generated_code << selected_color 
    end
    return(@generated_code) 
  end

  def make_a_guess
    
    puts "list of colors: #{@colors}" 
    puts "guess the first color"
    first_color = gets.chomp 
    $guess << first_color 
    puts 
    puts "#{$guess}"
    puts 
    puts "guess the second color"
    puts 
    second_color = gets.chomp 
    $guess << second_color 
    puts "#{$guess}"
    puts 
    puts "guess the third color" 
    puts 
    third_color = gets.chomp 
    $guess << third_color 
    puts "#{$guess}"
    puts 
    puts "Now, guess the final color" 
    puts 
    final_color = gets.chomp 
    $guess << final_color 
    puts "#{$guess}" 
    puts 
    
      #puts "previous guesses: #{@all_guesses}" 
  end

  def check_player_guess
    
     
    $guess.each_with_index do |color, index|  
      index_position = index 
          if @generated_code[index_position] == color
            $feedback_array << "black" 
          elsif  @generated_code.include?(color)
                  $feedback_array << "red" 
          else 
            $feedback_array << "incorrect" 
          end 
         
         # puts $round_nested_array ---> this prints out a whole lot of colors :< 
      end 
      puts "the feedback to your guess of #{$guess} is #{$feedback_array}" 
    $round_nested_array << $guess.clone
    $round_nested_array << $feedback_array.clone
    @all_guesses << $round_nested_array.clone
    #$feedback_array 
    loop_through_the_game_logic
  end
  
  def loop_through_the_game_logic  
    #puts $round_nested_array 
    if $guess == @generated_code or $feedback_array == ["black", "black", "black", "black"]
      puts "YOU WIN! your guess of #{$guess} matches the computer code: #{@generated_code}!"
return(@generated_code) 
    elsif @all_guesses.length < 8 
      
      puts "your guesses so far with their feedback are: #{@all_guesses}"
      $guess.clear  
      $feedback_array.clear
      $round_nested_array.clear 
      
      play_round 

    elsif @all_guesses.length == 8 
      puts "You're out of guesses. The correct code was: #{@generated_code}" 
    end 

  end

  def play_round
    # use gets to prompt the human for four colors 
    # call the check_player_guess and pass in the input from gets 
    # maybe write logic to keep calling play_round until either 
    # a max of x rounds, or until the perfect match is entered by the human 
    
    make_a_guess 
    check_player_guess 
    #loop_through_the_game_logic 
    
    #puts "Your guesses so far are: #{@all_guesses}"

  end

  def play_game

    generate_computer_code
    play_round
    
  end 

end 

game = Mastermind.new 
puts "Let's crack the code! You have 8 turns!"
    puts "Black peg means correct color, correct position"
    puts "Red peg means correct color, wrong position"
    puts "No peg means all colors are incorrect" 
game.play_game