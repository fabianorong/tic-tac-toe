class Board
    attr_reader :board

    def initialize
        @board = Array.new(9) {|n| n+1}
    end

    def display_board
        puts "\n
        #{board[0]} | #{board[1]} | #{board[2]}
        --+---+--
        #{board[3]} | #{board[4]} | #{board[5]}
        --+---+--
        #{board[6]} | #{board[7]} | #{board[8]}
        \n"
    end

    def update_board(symbol, location)
        board[location.to_i - 1] = symbol
        display_board
    end

    def row_win?(symbol)
        board[0..2].all? {|sym| sym == symbol} ||
        board[3..5].all? {|sym| sym == symbol} ||
        board[6..8].all? {|sym| sym == symbol}
    end

    def column_win?(symbol)
        board.values_at(0, 3, 6).all? {|sym| sym == symbol} ||
        board.values_at(1, 4, 7).all? {|sym| sym == symbol} ||
        board.values_at(2, 5, 8).all? {|sym| sym == symbol}
    end

    def diagonal_win?(symbol)
        board.values_at(0, 4, 8).all? {|sym| sym == symbol} ||
        board.values_at(2, 4, 6).all? {|sym| sym == symbol}         
    end 
    
    def legalmove?(location)
        return true if board[location.to_i - 1].is_a?(Numeric)
    end
end

class Game
    attr_reader :game_board, :moves, :player

    def initialize
        @game_board = Board.new
        @moves = 1       
        @player = 1 
        start_game
    end      

    def game_loop
        while @moves <= 9
            if @player == 1
                puts "Player #{@player}, which position would you like to play (choose between 1-9)?"
                location = gets.chomp until location.to_i.between?(1,9)
                if game_board.legalmove?(location)
                    game_board.update_board("X", location)                    
                else
                    location = ""
                    puts "\nPosition already taken, please choose another positon"
                    location = gets.chomp until location.to_i.between?(1,9)
                    game_board.update_board("X", location)
                end
                
                @moves += 1
                location = ""

                if game_board.column_win?("X") || game_board.row_win?("X") || game_board.diagonal_win?("X")
                    puts "Player #{@player} won"
                    break
                end

                @player += 1

            elsif @player == 2
                puts "Player #{@player}, which position would you like to play (choose between 1-9)?"
                location = gets.chomp until location.to_i.between?(1,9)
                if game_board.legalmove?(location)
                    game_board.update_board("O", location)                    
                else
                    location = ""
                    puts "\nPosition already taken, please choose another positon"
                    location = gets.chomp until location.to_i.between?(1,9)
                    game_board.update_board("O", location)
                end
                               
                @moves += 1     
                location = ""

                if game_board.column_win?("O") || game_board.row_win?("O") || game_board.diagonal_win?("O")
                    puts "Player #{@player} won"
                    break
                end

                @player -= 1
            
            end  
                     
        end                             
              
    end   
   
    def ask_for_new_game
        puts "\nwould you like to play again? [Y/N]"
        
        answer = gets.chomp
        answer = gets.chomp until answer.downcase == 'y' || answer.downcase == 'n'
        if answer.downcase == 'y'
            Game.new
        else
            puts "\nThanks for playing!"
        end
    end

    def start_game
        puts "\nWelcome to Tic Tac Toe"
        game_board.display_board
        game_loop
        ask_for_new_game        
    end
end

Game.new

    


