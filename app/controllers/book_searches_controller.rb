class BookSearchesController < ApplicationController

  def index
    @bookfind = BookFetcher.new

    if params[:author_input].present?
      @authors = []
      authors_search = @bookfind.get_books(params[:author_input])
      authors_search.map.with_index do |item, index|
        @authors << authors_search[index]["volumeInfo"]["authors"][0]
    end

    @authors_final = @authors.map
    end
  end

end
