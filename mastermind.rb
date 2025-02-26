class Mastermind 
  
  $round_count = 0 
  $guess = [] 
  $feedback_array = [] 
  $round_nested_array = []
   
  
    def initialize
    @colors = ["green", "blue", "pink", "yellow", "orange"] 
    @generated_code = [] 
    @all_guesses = [] 
    @human_path = 0
    @computer_path = 0 
    end
    

  def generate_code
    # use rand method to randomly generate code of four colors from array of colors 
   
    4.times do 
      random_num = rand(5) 
      selected_color = @colors[random_num]
      @generated_code << selected_color 
    end
    return(@generated_code) 
  end

  def guess_colors
    puts "------------------------------" 
    puts "list of colors to choose from: "
    puts "#{@colors[0]}" 
    puts "#{@colors[1]}" 
    puts "#{@colors[2]}"
    puts "#{@colors[3]}" 
    puts "#{@colors[4]}"
    puts "------------------------------" 
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
  
  end

def random_guess
  #the computer generates a random guess for the firest round. 
  
  4.times do 
    random_num = rand(5) 
    selected_color = @colors[random_num]
    $guess << selected_color 
    puts $guess 
    ackn = gets.chomp 
    puts ackn 
  end
end

  def put_guesses
    $round_count = 0 
    puts 
    puts "your guesses so far with their feedback are:" 
    puts 
    @all_guesses.each do |round| 

      $round_count += 1 
      puts "Round: #{$round_count} --------------------" 
      puts "Your Guess: #{round[0].inspect}"
      puts "Its Feedback: #{round[1].inspect}" 
    end   #  <---- closing the do end block 
  end
  
  def computer_loop 
    if $feedback_array == ["black", "black", "black", "black"] 
      puts "YOU WIN!! you guessed the #{@generated_code} code" 
    elsif @all_guesses.length < 8 or $round_count <= 8 
      put_guesses 
      play_round 
    else 
      puts "You are out of guesses; you lost this game"
      puts "the code was #{@generated_code}" 
    end 
  end 

  def human_loop
    if $feedback_array == ["black", "black", "black", "black"] 
      puts "YOU WIN!! you guessed the #{@generated_code} code" 
    elsif @all_guesses.length < 8 or $round_count <= 8 
      put_guesses 
      
      $guess.clear  
      $feedback_array.clear
      $round_nested_array.clear
      play_round 
    else 
      puts "You are out of guesses; you lost this game"
      puts "the code was #{@generated_code}" 
    end 
  end

  def validate_guess
    
    color_counts = Hash.new(0) 

    $guess.each_with_index do |color, index| 

      index_position = index 
       color_counts[color] += 1 
       # color counts is a hash to hold each instance of the respective colors when found in a guess. 
      
          if @generated_code[index_position] == color
            $feedback_array << "black" 


          elsif  @generated_code.include?(color) and @generated_code.count(color) >= color_counts[color] 

           # color_index = @generated_code.index(color) 

           # guessed_color_index = $guess.index(color) 

            #if @generated_code.count(color) == 1 and 
               # @generated_code[color_index] == $guess[guessed_color_index]

             # $feedback_array << "incorrect"

            #else
                $feedback_array << "red"  
            #end
                  
          else 
            $feedback_array << "incorrect" 
          end 
          
      end 
      puts "the feedback to your guess of #{$guess} is #{$feedback_array}" 
    $round_nested_array << $guess.clone
    $round_nested_array << $feedback_array.clone
    @all_guesses << $round_nested_array.clone
    
  end
  
  def add_new_colors
    # this method should check the $guess to see if any array positions are empty
    # if so, run random guess style logic on it, or refactor that method to suit this step 
    $guess.each_with_index do |color, index| 
      if color == ""
        # determine random color using the @colors array of options 
        # may want to account for already determined incorrect or out of place colors 
        random_index = rand(@colors.length) # intending to pass in the number of items available in colors array
        # to the rand method to randomly pick an available color in the colors array 
        # now, we need to account for any instance of that color having been guessed in this position before. 
        color << @colors[random_index]
        #could make a conditional here to randomize reds that duplicate black feedback
      end
    end
  end

  def educated_guess
    $next_guess_queue = Array.new(4, "") # this is to temporarily hold the next guess in educated_guess 

    $feedback_array.each_with_index do |info, index|  
      next_i = index + 1
      previous_i = index - 1
      if info == "black"  
         $next_guess_queue[index] = $guess[index] 
         
      elsif info == "red" 
        if next_i < $feedback_array.length and $feedback_array[next_i] != "black"
          $next_guess_queue[next_i] = $guess[index] 
          
        elsif   previous_i >= 0 and $feedback_array[previous_i] != "black"
          $next_guess_queue[previous_i] = $guess[index] 
          
        else #the color needs to go to the only remaining array index. . . 
          last_available_index = $guess.each_index.select { |index| $feedback_array[index] != "black" and $guess[index].nil? }.last 
          $next_guess_queue[last_available_index] = $guess[index] if last_available_index 
          
        end
      elsif info == "incorrect" 
        @colors.delete($guess[index]) 
      end
    end

      $guess.clear 
      $next_guess_queue.each_with_index do |color, index|
        $guess[index] = color 
      end
      $next_guess_queue.clear

      add_new_colors 

      puts $guess 
      i_see = gets.chomp 
      puts i_see
    $feedback_array.clear
    $round_nested_array.clear
  end

  def play_round
    if @human_path == 1
    
      #the human guesses in this path 
      guess_colors  
      validate_guess 
      human_loop
    elsif @computer_path == 1 
      #the computer guesses in this path 
     if $round_count < 1
      
       answer = gets.chomp 
       puts answer 
      random_guess
      validate_guess 
      computer_loop 
     else 
      answer = gets.chomp 
      puts answer 
      educated_guess
      validate_guess
      computer_loop
     end 

    end
    
  end

  def display_colors 
    puts
    puts "------------------------------" 
    puts "list of colors to choose from: "
    puts "#{@colors[0]}" 
    puts "#{@colors[1]}" 
    puts "#{@colors[2]}"
    puts "#{@colors[3]}" 
    puts "#{@colors[4]}"
    puts "------------------------------"
    puts 
  end

  def human_generates_code 
    display_colors 
    puts "choose the first color in the code"
    first = gets.chomp 
    @generated_code << first
    puts "choose the second color in the code" 
    second = gets.chomp 
    @generated_code << second
    puts "choose the third color in the code"
    third = gets.chomp 
    @generated_code << third
    puts "choose one more color for the code"
    last = gets.chomp 
    @generated_code << last 
    puts "The code you chose is: #{@generated_code}"
  end

  def determine_roles 
    puts "do you want to play, or watch?"
    puts "To guess the code, type P"
    puts "To make the code yourself and watch the computer solve it, type W"
    determination = gets.chomp 

    if determination == "P"
      
      puts "the human is guessing the code this round!"
      @human_path += 1 
      generate_code 
      play_round
    elsif determination == "W"
      puts "the computer is guessing the code this round!"
      @computer_path += 1 
      human_generates_code
      play_round

   # else 
      #puts "please type either  P  or  W  "

    end

  end

end 

game = Mastermind.new 
puts "----------"
puts "Let's crack the code! You have 8 turns!"
    puts "Black peg means correct color, correct position"
    puts "Red peg means correct color, wrong position"
    puts "incorrect means that colors is nowhere in the code"  
puts "----------"
game.determine_roles