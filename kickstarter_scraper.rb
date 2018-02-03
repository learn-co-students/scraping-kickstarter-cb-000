# require libraries/modules here
# no Open-URI request, so don't need to require 'open-uri'
require 'nokogiri'

# Each project has a title, an image, a short description, a location and some funding details
# The goal is to collect this information for each project and build a hash for each project
# These individual project hashes will be collected into a larger hash called projects

def create_project_hash
  # open a file and read it into a variable
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
end



# returns a hash
# project titles point to a hash of info
# each project has an image link hosted on AmazonAWS
# each project has a description which is a string
# each project has a location which is a string
# each project has percentage funded listed which is an integer
