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
  end
  puts "you seeing this step? -- random first guess"
       answer = gets.chomp 
       puts answer 
end


  def game_loop
    puts "now we're going to check that info agains the win / loss logic. acknowledge this :)"
    got_it = gets.chomp 
    puts got_it 

    if $guess == @generated_code or $feedback_array == ["black", "black", "black", "black"]
      puts "YOU WIN! your guess of #{$guess} matches the computer code: #{@generated_code}!"
return(@generated_code) 
    elsif @all_guesses.length < 8 
     
      puts 
      puts "your guesses so far with their feedback are:" 
      puts 
      @all_guesses.each do |round| 
        $round_count += 1 
        puts "Round: #{$round_count} --------------------" 
        puts "Your Guess: #{round[0].inspect}"
        puts "Its Feedback: #{round[1].inspect}" 
      end   #  <---- closing the do end block 
      puts 
      puts "here is where the logic splits for the computer. It prevents game_loop from emptying the arrays. ackn"
      ackn = gets.chomp 
      puts ackn 

      if @computer_path == 1
      
        if @all_guesses.length == 8 or $round_count > 8 
          puts "You're out of guesses. The correct code was: #{@generated_code}" 
        else 
          play_round
        end 
         
      end
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

    if @computer_path == 1 
      puts "we're about to iterate over the $guess array"
    puts "validate that you're with me"
    respond = gets.chomp 
    puts respond 
    end

    $guess.each_with_index do |color, index| 

      index_position = index 
       color_counts[color] += 1 

      
          if @generated_code[index_position] == color
            $feedback_array << "black" 
          elsif  @generated_code.include?(color) and @generated_code.count(color) >= color_counts[color] 
            color_index = @generated_code.index(color) 
            guessed_color_index = $guess.index(color) 
            if @generated_code.count(color) == 1 and @generated_code[color_index] == $guess[guessed_color_index]
              $feedback_array << "incorrect"
            else
                $feedback_array << "red"  
            end
                  
          else 
            $feedback_array << "incorrect" 
          end 
         
        puts "we just populated the $feedback_array: #{$feedback_array}"
        puts "pause to acknowledge"
        tell_em = gets.chomp 
        puts tell_em 
          
      end 
      puts "the feedback to your guess of #{$guess} is #{$feedback_array}" 
    $round_nested_array << $guess.clone
    $round_nested_array << $feedback_array.clone
    @all_guesses << $round_nested_array.clone
    puts "now the program should have output the info of the round, and pushed info into the arrays"
    puts "the $round_nested: #{$round_nested_array} the @all_guesses: #{@all_guesses}" 
    hmm = gets.chomp 
    puts hmm 
    game_loop
  end
  
  def educated_guess

    puts "next step: educated_guess. This is before it runs. validate and move on to see how it runs"
    validate = gets.chomp 
    puts validate 

    $feedback_array.each_with_index do |color, index|  
      next_i = index + 1
      previous_i = index - 1
      if $feedback_array[index] == "black" 
        @generated_code[index] = color 
         $guess[index] = @generated_code[index] 
      elsif $feedback_array[index] == "red" 
        if next_i < $feedback_array.length and $feedback_array[next_i] != "black"
          $guess[next_i] = color 
        elsif   previous_i >= 0 and $feedback_array[previous_i] != "black"
          $guess[previous_i] = color 
        else #the color needs to go to the only remaining array index. . . 
          last_available_index = $guess.each_index.select { |index| $feedback_array[index] != "black" and $guess[index].nil? }.last 
          $guess[last_available_index] = color if last_available_index 
        end
      elsif $feedback_array[index] == "incorrect" 
        @colors.delete(color) 
      end
    end
    puts "the current feedback_array is #{$feedback_array}, the round_nested_array is #{$round_nested_array}"
    puts "the guess array is #{$guess} and all but the guess are about to be cleared by the method."
    puts "you keeping up? "
    answer_it = gets.chomp 
    puts answer_it 
    $feedback_array.clear
    $round_nested_array.clear
    puts "now the feedback array and round nested should be cleared: #{$round_nested_array}, and #{$feedback_array}" 
  end
  

  def play_round
    if @human_path == 1
      puts "there is #{@human_path} person playing!"
      #the human guesses in this path 
      guess_colors  
      validate_guess 
    elsif @computer_path == 1 
      puts "you seeing this step?"
      verify_round = gets.chomp 
      puts verify_round
      #the computer guesses in this path 
     if $round_count < 1
       puts "you seeing this step? -- the round_count is #{$round_count}. the conditional indicates < 1"
       answer = gets.chomp 
       puts answer 
      random_guess
      validate_guess 
     else 
      puts "you seeing this step? -- the round_count is #{$round_count}. the conditional indicates > 1"
      answer = gets.chomp 
      puts answer 
      educated_guess
      validate_guess
     end 

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