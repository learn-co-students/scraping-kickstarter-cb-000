# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  hash = {}
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    image_link = project.css("div.project-thumbnail a img").attribute("src").value
    description = project.css("p.bbcard_blurb").text
    location = project.css("span.location-name").text
    percent_funded = project.css("li.funded strong").text.gsub("%", "").to_i
    hash[title] = {title: title, image_link: image_link, description: description, location: location, percent_funded: percent_funded}
  end
  hash
end

create_project_hash
