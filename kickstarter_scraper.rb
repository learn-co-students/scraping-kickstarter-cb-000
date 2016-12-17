# require libraries/modules here
require 'nokogiri'
require 'pry'


# projects: kickstarter.css("li.project.grid_4")
# title: project.css('h2.bbcard_name strong a').text
# img href: project.css('.project-thumbnail a img').attribute('src').value
# description: project.css("p.bbcard_blurb").text
# location: project.css('.project-meta li a span.location-name').text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  #iterate through projects
  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      :image_link => project.css('.project-thumbnail a img').attribute('src').value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css('.project-meta li a span.location-name').text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

    }
  end

  #returnt the hash
  projects




end

create_project_hash
