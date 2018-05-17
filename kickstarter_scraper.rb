# require libraries/modules here
require 'nokogiri'
require 'pry'

# Create a data hash formatted as below:
#
# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }

def create_project_hash

  # Use File.read instead of open-uri because it's not a live site
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  kickstarter_projects = kickstarter.css("li.project.grid_4")

  projects = {}

  kickstarter_projects.each do |project|
    title = project.css("h2.bbcard_name strong a").text

    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end

  projects

end
