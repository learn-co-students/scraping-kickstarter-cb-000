# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  projects = {}
  html = File.read('./fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  kickstarter.css("li.project.grid_4").each do |project|
    # projects[project] = {}
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end #kickstarter
  projects #return hash
end

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image_link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i



create_project_hash
# open fixtures/kickstarter.html
# Each project has a title, an image, a short description, a location and some funding details.
# :projects => { |variable|               .project_card
#   "My Great Project"  => {              .bbcard_name a
#     :image_link => "Image Link",        .project-thumbnail img.src
#     :description => "Description",      .bbcard_blurb
#     :location => "Location",            .project-meta li(first if needed else jsut li )  location-name
#     :percent_funded => "Percent Funded" .project-stats .funded  strong
#   }
# }
