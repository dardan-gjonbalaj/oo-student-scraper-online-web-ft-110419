require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").each { |student|
      array_of_students = {}
      array_of_students[:name] = student.css("h4.student-name").text
      array_of_students[:location] = student.css("p.student-location").text
      array_of_students[:profile_url] = "#{student.css("a").attribute("href").value}" 
      students << array_of_students
    }
    students  
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    
    doc = Nokogiri::HTML(open(profile_url))

  #  binding.pry
    doc.css("div.main-wrapper.profile .social-icon-container a").each { |social|
      if social.attribute("href").value.include?("twitter")
        profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        profile[:github] = social.attribute("href").value
      else
        profile[:blog] = social.attribute("href").value
      end 
    }
    
    profile[:profile_quote] = doc.css("div.main-wrapper.profile .profile-quote").text
    profile[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text
  
    profile
  end



end #end of class


#profile_Page
#doc.css("div.main-wrapper.profile .social-icon-container a").each {|x| puts x.attribute("href").value}

#quote : doc.css("div.main-wrapper.profile .profile-quote").text


  #names
#doc.css("div.roster-cards-container div.card-text-container h4.student-name").each { |x| puts x.text}
#doc.css("div.roster-cards-container div.student-card a h4").each {|x| x.text}
  
  #urls
#doc.css("div.roster-cards-container div.student-card a").each {|x| puts x['href']}
#doc.css("div.roster-cards-container div.student-card a").each {|x| puts x.attribute("href").value }

  #locations
#doc.css("div.roster-cards-container div.student-card p.student-location").each {|x| puts x.text}

 