[Series, Banner, Actor].each do |model_class|
  p "Destroying #{model_class.count} #{model_class}..."
  model_class.destroy_all
end

# Series.create!(
#   [
#     {
#       name: 'Archer (2009)'
#     },
#     {
#       name: 'The Brink'
#     },
#     {
#       name: 'House'
#     },
#     {
#       name: 'Last Week Tonight'
#     },
#     {
#       name: 'Game of Thrones'
#     }
#   ]
# )

# p "Created #{Series.count} Series"
