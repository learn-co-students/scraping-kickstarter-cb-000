require 'nokogiri'

def create_project_hash
  file = File.open("./fixtures/kickstarter.html")
  projects = Nokogiri::HTML(file).search('li.project.grid_4')
  projects_hash = {}

  projects.map do |project|
    title = project.search('h2.bbcard_name strong a').text

    projects_hash[title.to_sym] = {
      image_link: project.search('div.project-thumbnail a img').attribute('src').value,
      description: project.search('p.bbcard_blurb').text,
      location: project.search('ul.project-meta span.location-name').text,
      percent_funded: project.search("ul.project-stats li.first.funded strong").text.gsub('%', '').to_i
    }
  end

  projects_hash
end
