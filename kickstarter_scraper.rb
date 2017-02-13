# require libraries/modules here
require "nokogiri"


def create_project_hash
	projects = {}
  doc = Nokogiri::HTML(File.read("fixtures/kickstarter.html"))
	doc.css("div.project-card").each do |card|
		project = {
			image_link: card.css(".project-thumbnail img").attribute('src'),
			description: card.css("p.bbcard_blurb").text,
			location: card.css("span.location-name").text,
			percent_funded:  card.css(".first.funded > strong").text.to_i
		}
		projects[card.css('.bbcard_name a').text] = project
	end
	projects
end