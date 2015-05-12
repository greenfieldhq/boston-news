class Api::SearchController < ApplicationController
  def index
    search = BostonNewsIndex.query(query_string: {
      fields: [:title, :body],
      query: params[:query],
      default_operator: 'and'
    })

    news = search.load()

    render json: news
  end
end
