# require libraries/modules here
require 'nokogiri'
require 'pry'

def load_file
  html = File.read('fixtures/kickstarter.html')
  doc = Nokogiri::HTML(html)
end

def get_projects
  projects_raw = load_file.css('.project-card')
end

def create_project_hash
  hash = {}
  get_projects.each do |project|
    ky = project.css('.bbcard_name > strong > a').text
    hash[ky.to_sym] = {
      :image_link => project.css('.projectphoto-little')[0]["src"],
      :description => project.css('.bbcard_blurb').text,
      :location => project.css('.location-name').text,
      :percent_funded => project.css('.first.funded > strong').text.gsub("%", "").to_i
    }
  end
  hash
end
