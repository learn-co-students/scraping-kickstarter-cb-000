# require libraries/modules here
require 'nokogiri'

def create_project_hash

  projects = {}

  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  kickstarter.css('.project.grid_4').each do |pj|
    projects[pj.css('.bbcard_name strong a').text] = {
      image_link: pj.css('img').attribute('src').text,
      description: pj.css('.bbcard_blurb').text,
      location: pj.css('.location-name').text,
      percent_funded: pj.css('.funded strong').text.to_i
    }
  end

  # im bored.
  # p projects["Moby Dick: An Oratorio"]
  projects
end

p create_project_hash["Moby Dick: An Oratorio"]
