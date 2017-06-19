require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

  kickstarter.css("li.project.grid_4").each do |project|
    # get the title of each project and use it as the key (in symbol format) to create a hash within the projects hash
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      #grab all the values from the html for the project
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end


  #return the projects hash
  projects
end
