class Story < ActiveRecord::Base
  update_index('boston_news#story') { self }
end
