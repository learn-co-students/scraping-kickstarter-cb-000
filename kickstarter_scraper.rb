# require libraries/modules here
require "nokogiri"
require "pry"

html = File.read("fixtures/kickstarter.html")
DOC = Nokogiri::HTML(html).css("li.project.grid_4")

# binding.pry
def create_project_hash
  # write your code here
  projects = {}
  DOC.collect do |project|
    project_name = project.css("h2.bbcard_name a").text
    project_img = project.css(".project-thumbnail a img").attr("src").value
    project_description = project.css("p.bbcard_blurb").text.strip
    project_location = project.css(".location-name").text
    project_percent_funded = project.css("li.first.funded").text.match(/\d+%/)

    projects[project_name] = {
      image_link: project_img
      description: project_description
      location: project_location
      percent_funded: project_percent_funded
    }
  end
end
