class BookFetcher

  attr_accessor :titles, :authors

  def initialize
    @conn = Faraday.new(:url => 'https://www.googleapis.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP

    end
    @titles = []
    @authors = []

  end

    def get_books(search_term)
      response = @conn.get do |req|
        req.url "books/v1/volumes?q=#{search_term}"
        req.headers['Content-Type'] = 'application/json'
    end

    json = JSON.parse(response.body)

    items = json["items"]
    # authors = []
    items.each_with_index do |item, index|
      @authors << items[index]["volumeInfo"]["authors"]
      @titles << items[index]["volumeInfo"]["title"]

    end
  end


end
