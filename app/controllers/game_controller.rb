class GameController < ApplicationController

  def new
    data = TicTacToe.play(Board.new_board)
    render :json => data, :status => :ok
  end

  def create
    data = TicTacToe.play(Board.new(params[:board]))
    render :json => data, :status => :ok
  end
end
