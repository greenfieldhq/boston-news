class BostonNewsIndex < Chewy::Index
  define_type Story do
    field :title
    field :body
  end
end
