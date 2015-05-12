class NewsSearch

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def index
    BostonNewsIndex
  end

  def query
    index.query(query_string: {fields: [:title, :body], query: @params, default_operator: 'and'}) if @params
  end

end
