require 'nokogiri' 
require 'pry'  

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css("li.project.grid_4").each do |item|

    proj_headlines = item.css("h2").text.scan(/\b.*\n/).collect {|item| item.gsub("\n","")}.reject {|item| item == "by"}

    projects[proj_headlines[0]] = {
      :image_link => item.css("img").attribute('src').text,
      :description => item.css("p.bbcard_blurb").text.gsub("\n",""),
      :location => item.css("ul.project-meta span.location-name").text,
      :percent_funded => item.css("ul.project-stats li.first.funded strong").text.to_i
    }
    
  end

  projects
  
end


create_project_hash
