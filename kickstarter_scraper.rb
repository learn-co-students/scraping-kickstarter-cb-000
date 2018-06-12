require 'nokogiri'
require 'pry'

def create_project_hash

  kickstarter = Nokogiri::HTML(File.read("fixtures/kickstarter.html"))
  post_hash = {}
  kickstarter.css("li.project.grid_4").each do |post|
    title = post.css("div h2.bbcard_name strong a").text

    post_hash[title.to_sym] = {
      :image_link => post.css("div.project-thumbnail a img").attribute("src").value,
      :description => post.css("div p.bbcard_blurb").text,
      :location => post.css("ul.project-meta span.location-name").text,
      :percent_funded => post.css("ul.project-status li.pleged strong").text.gsub("%","").to_i
    }
 end

  post_hash
end


# kickstarter.css("li.project.grid_4") == this is where the projects are being stored
