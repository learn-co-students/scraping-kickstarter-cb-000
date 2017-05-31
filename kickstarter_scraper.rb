require 'nokogiri'

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  project_elements =
    kickstarter.css(
      "section#projects div.container ul li.project div.project-card-wrap div.project-card")
  projects = Hash.new
  project_elements.each{|project_element|
    project_title = project_element.css("h2.bbcard_name strong a").text
    projects[project_title.to_sym] = {
      image_link: project_element.css("div.project-thumbnail a img").attribute("src").value,
      description: project_element.css("p.bbcard_blurb").text,
      location: project_element.css("ul.project-meta li span.location-name").text,
      percent_funded: project_element.css("ul.project-stats li.funded strong").text.to_i
    }
  }
  projects_hash = {projects: projects} ## this is what the README text says should be returned!!
  return projects ## this is what the rspec test methods want to be returned!!
end
