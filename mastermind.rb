class Mastermind 
  
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
    
      #puts "previous guesses: #{@all_guesses}" 
  end

  def game_loop
    #puts $round_nested_array 
    if $guess == @generated_code or $feedback_array == ["black", "black", "black", "black"]
      puts "YOU WIN! your guess of #{$guess} matches the computer code: #{@generated_code}!"
return(@generated_code) 
    elsif @all_guesses.length < 8 
      round_count = 0
      puts 
      puts "your guesses so far with their feedback are:"
      puts 
      @all_guesses.each do |round| 
        round_count += 1 
        puts "Round: #{round_count} --------------------" 
        puts "Your Guess: #{round[0].inspect}"
        puts "Its Feedback: #{round[1].inspect}" 
        
      end
      puts 
      $guess.clear  
      $feedback_array.clear
      $round_nested_array.clear 
      
      play_round 

    elsif @all_guesses.length == 8 
      puts "You're out of guesses. The correct code was: #{@generated_code}" 
    end 

  end

  def validate_guess
    
    color_counts = Hash.new(0) 

    $guess.each_with_index do |color, index| 

      index_position = index 
       color_counts[color] += 1 
      
          if @generated_code[index_position] == color
            $feedback_array << "black" 
          elsif  @generated_code.include?(color) and @generated_code.count(color) >= color_counts[color]
                  $feedback_array << "red" 
          else 
            $feedback_array << "incorrect" 
          end 
         
        
          
      end 
      puts "the feedback to your guess of #{$guess} is #{$feedback_array}" 
    $round_nested_array << $guess.clone
    $round_nested_array << $feedback_array.clone
    @all_guesses << $round_nested_array.clone
    game_loop
  end
  
  

  def play_round
    if @human_path == 1
      puts "the human is guessing the code this round!"
      guess_colors  
      validate_guess 
    elsif @computer_path == 1 
      puts "the computer is guessing the code this round!"
    end
    
  end

  def human_generates_code 
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
      @human_path += 1 
      generate_code 
      play_round
    elsif determination == "W"
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
    puts "No peg means all colors are incorrect" 
puts "----------"
game.determine_roles