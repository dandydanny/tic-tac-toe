require 'rails_helper'

describe Board do

  let(:board)  {Board.new(Array.new(9,n))}
  let(:o) {Appdata::TOKENS[:computer]}
  let(:x) {Appdata::TOKENS[:player]}
  let(:n) {Appdata::TOKENS[:blank]}

  it "should return the correct default length of board" do
    expect(board.grid.length).to eq(9)
  end

  it "should return a board object" do
    expect(Board.new_board.class).to eq(Board)
  end

  it "should return the correct length when initialized with specific board size" do
    board = Board.new(Array.new(16))
    expect(board.grid.length).to eq(16)
  end

  it "should return false for empty board" do
    expect(board.board_full?).to eq(false)
  end

  it "should return false for empty position on board" do
    grid = [o, x, o,
            x, n, x,
            x, o, x]
    board = Board.new(grid)
    expect(board.board_full?).to eq(false)
  end

  it "should return true for filled board" do
    grid = [o, x, o,
            x, o, x,
            x, o, x]
    board = Board.new(grid)
    expect(board.board_full?).to eq(true)
  end

  it "should assign player to board position" do
    token, position = o, 7
    board.assign_token_to(token, position)
    expect(board.grid[7]).to eq(o)
  end

  it "should assign player to board position" do
    token, position = x, 3
    board.assign_token_to(token, position)
    expect(board.grid[3]).to eq(x)
  end

  it "should return the index positions of availible board positions" do
    grid = [o,o,o,
            x,n,n,
            n,x,n]
    board = Board.new(grid)
    expect(board.indexes_of_available_spaces).to eq([4,5,6,8])
  end

  it "should return index positions of availible board positions" do
    grid = [o,n,o,
            x,n,o,
            n,x,o]
    board = Board.new(grid)
    expect(board.indexes_of_available_spaces).to eq([1,4,6])
  end

  it "should return empty array with full board" do
    grid = [o,x,o,
            x,x,o,
            o,x,o]
    board = Board.new(grid)
    expect(board.indexes_of_available_spaces).to eq([])
  end

  it "should return all positions with empty board" do
    grid = [n,n,n,
            n,n,n,
            n,n,n]
    board = Board.new(grid)
    expect(board.indexes_of_available_spaces).to eq([0,1,2,3,4,5,6,7,8])
  end

  it "should return nested array of all possible wins" do
    expect(board.possible_wins.length).to eq(8)
  end

  it "should return 3 cell count for win combination" do
    expect(board.possible_wins.first.length).to eq(3)
  end

  it "should return 3 cell count for win combination" do
    expect(board.possible_wins.last.length).to eq(3)
  end
end

