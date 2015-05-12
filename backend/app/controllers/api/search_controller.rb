class Api::SearchController < ApplicationController
  def index
    search = NewsSearch.new(params[:query])
    news = search.query.only(:id).load()

    render json: news
  end
end
