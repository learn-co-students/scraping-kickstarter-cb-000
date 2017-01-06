# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))

  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|
    name = project.css('h2.bbcard_name strong a').text
    projects[name] = each_hash(project)
  end

  projects
  #binding.pry
end

def each_hash(project)
  { :image_link => project.css('.projectphoto-little').attr('src').text,
    :description => project.css('.bbcard_blurb').text,
    :location => project.css('.project-meta .location-name').text,
    :percent_funded => project.css('.project-stats .first.funded strong').text.to_i}
end

create_project_hash
