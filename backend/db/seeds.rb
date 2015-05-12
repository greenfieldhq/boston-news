# Disables Chewy indexing (everything is indexed at the end)
Chewy.strategy(:bypass)

# Require all seeders
Dir[Rails.root.join("db/seeders/**/*.rb")].each { |f| require f }

# Run environment specific seeds
["all", Rails.env].each do |seed|
  seed_file = Rails.root.join("db/seeds/#{seed}.rb")

  if File.exists?(seed_file)
    puts "*** Loading #{seed} seed data"
    require seed_file
  end
end

puts "-=-=-=-=-=-=-=-=- Updating Elastic Indexes -=-=-=-=-=-=-=-=-=-"
BostonNewsIndex.import
