class ComputerAi

  def initialize(params)
    @game_piece = params[:symbol]
    @enemy_piece = params[:opponent]
    @efficent_value = -32
  end

  def assert_values(board)
    position_values = {}
    board.indexes_of_available_spaces.each do |empty_position|
      possible_board = TicTacToeBoard.new(board.grid.clone)
      possible_board.assign_token_to(@game_piece, empty_position)
      position_values[empty_position] = evaluate_board(possible_board, @enemy_piece, @game_piece)
    end

    select_random_index(position_values)
  end

  def evaluate_board(board, current_player, passing_player, depth=1)
    if gameover?(board) || @efficent_value > (32 / depth)

      return create_value(board) / depth
    end
    board_values = []

    board.indexes_of_available_spaces.each do |empty_position|
      played_board = TicTacToeBoard.new(board.grid.clone)
      played_board.assign_token_to(current_player, empty_position)

      board_values << evaluate_board(played_board, passing_player, current_player, depth +1)

      @efficent_value = board_values.last if board_values.last > @efficent_value
    end

    if current_player == @game_piece
      board_values.compact.max
    else
      board_values.compact.min
    end
  end

  def select_random_index(position_values)
    best_positions = []
    max_value = position_values.each_value.max
    position_values.each_pair do |index, value|
      best_positions << index if value == max_value
    end
    best_positions.sample
  end

  def gameover?(board)
    game = GamePlay.new(board)
    game.gameover?
  end

  def create_value(board)
    game = GamePlay.new(board)
    returning_value =  0
    returning_value =  32 if game.winner_of == @game_piece
    returning_value = -32 if game.winner_of == @enemy_piece
    returning_value =  0 if game.tie_game?
    returning_value
  end

end

