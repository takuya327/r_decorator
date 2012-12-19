class AuthorsController < ApplicationController
  def index
    if params[:variable_type] == 'array'
      @authors = Author.all
    else
      @authors = Author.scoped
    end
  end

  def show
    @author = Author.find params[:id]
  end
end
