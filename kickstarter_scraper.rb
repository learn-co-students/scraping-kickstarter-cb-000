require "pry"
require "nokogiri"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project-card").each do |project|
    title = project.css("h2 a").text
    projects[title.to_sym]= {
      :image_link => project.css(".project-thumbnail img").attribute("src").value,
      :description => project.css(".bbcard_blurb").text,
      :location => project.css(".location-name").text,
      :percent_funded => project.css(".funded strong").text.delete("%").to_i
    }
  end
  projects
end
