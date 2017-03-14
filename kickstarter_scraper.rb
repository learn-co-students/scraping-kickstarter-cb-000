# require libraries/modules here
require 'nokogiri'
require 'pry'
def create_project_hash
  # write your code here
  #file_to_read = "file:///Users/bristolta/.atom/.learn-ide/home/tahbristol-48246/code/labs/scraping-kickstarter-cb-000/fixtures/kickstarter.html"
  hash = {}
  html  = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = kickstarter.css(".project.grid_4")
=begin
  project_name = projects.css(".bbcard_name a")
  project_image = projects.css(".projectphoto-little")
  project_description = projects.css(".bbcard_blurb")
  project_location = projects.css(".project-meta a")
  project_percentage_funded = projects.css(".first.funded")


  project_percentage_funded.each do |name|
         name = name.text
         puts name.scan(/\d+/)

=end

projects.each do |project|
  title = project.css(".bbcard_name a").text

  percent = project.css(".first.funded").text
  percent = percent.match(/\d+/).to_s

  hash[title.to_sym] = {
    :image_link => project.css(".projectphoto-little").attr('src').text.strip,
    :description => project.css(".bbcard_blurb").text.strip,
    :location => project.css(".project-meta a").text.strip,
    :percent_funded => percent.to_i
  }

end
 hash


end
