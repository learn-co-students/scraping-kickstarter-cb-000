# require libraries/modules here
 
require 'nokogiri'
require 'pry'
 
# projects: kickstarter.css("li.project.grid_4")
#    also, I used ('div.project-card') and it worked great
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

#easiest to simply look at the html source and start with the closest
#div to your data.  

class KickStarterScraper 

  attr_accessor :projects, :kickstarter


  def initialize
    @projects = {}
  end


  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    @kickstarter = Nokogiri::HTML(html)
  
    @kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      @projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("ul.project-meta span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
    end
  
    # return the projects hash
    @projects
  end

  def printHash
    @projects.each do |key, value|
      puts("Project Name:  #{key}\n")
      puts("Image Link:  #{@projects[key][:image_link]}\n")
      puts("Description: #{@projects[key][:description]}\n")
      puts("Location: #{@projects[key][:location]}\n")
      puts("Percent Funded:  #{@projects[key][:percent_funded]}\n\n")
    end
    " "
  end
end