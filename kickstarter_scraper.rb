require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstart = Nokogiri::HTML(html)

  projects = {}
  get_projects(kickstart).each do |proj|
    title = get_title(proj)
    projects[title.to_sym] = {
      :image_link => get_image_link(proj),
      :description => get_description(proj),
      :location => get_location(proj),
      :percent_funded => get_percent_funded(proj)
    }
  end
  projects
end

def get_projects(page)
  page.css('li.project.grid_4')
end
def get_title(project)
  project.css('h2.bbcard_name strong a').text
end
def get_image_link(project)
  project.css('div.project-thumbnail a img').attribute('src').value
end
def get_description(project)
  project.css('p.bbcard_blurb').text
end
def get_location(project)
  project.css('ul.project-meta span.location-name').text
end
def get_percent_funded(project)
  project.css('ul.project-stats li.first.funded strong').text.gsub('%','').to_i
end

create_project_hash
