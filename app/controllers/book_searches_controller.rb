class BookSearchesController < ApplicationController

  def index
    @query = params[:search].to_s
    @bookfind = BookFetcher.new

    if params[:search].present?
      @authors = []
      @titles = []
      books_search = @bookfind.get_books(params[:search])

        books_search.map.with_index do |item, index|
          @authors << books_search[index]["volumeInfo"]["authors"][0]
          @titles << books_search[index]["volumeInfo"]["title"]
        end
    books = @titles.zip(@authors)
    @books_final = books.map {|author, book| "#{author}, #{book}"}
    end
  end

end
