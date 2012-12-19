class BooksController < ApplicationController
  def show
    @book = Author.find(params[:author_id]).books.find(params[:id])
  end
end
