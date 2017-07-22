# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  # iterate through the projects
  kickstarter.css('li.project.grid_4').each do |project|
    # make each project title a key, and the value is a hash with each of our other data points as keys
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  # return the completed data structure
  projects

end


# test - enter the following commands at the pry prompt
# kickstarter = create_project_hash
# kickstarter.css("li.project.grid_4").first
# project = _
# project.css("h2.bbcard_name strong a").text #=> "Moby Dick: An Oratorio"
# project.css("div.project-thumbnail a img").attribute("src").value #=> "https://s3.amazonaws.com/ksr/projects/845788/photo-little.jpg?1391022013"
# project.css("p.bbcard_blurb").text #=> "\nFour young composers join forces with an indie orchestra to present this musical reflection on a literary masterpiece.\n"
# project.css("span.location-name").text #=> "Brooklyn, NY"
# project.css("ul.project-stats li.first.funded strong").text #=> "77%"
# project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i #=> 77 (extract the integer)

# SUMMARY
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


# binding.pry
