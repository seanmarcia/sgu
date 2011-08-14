require 'rubygems'
require 'nokogiri'
require 'open-uri'
        
        
url = 'http://www.theskepticsguide.org/archive/podcast.aspx?mid=1'
doc = Nokogiri::HTML(open(url))

mp3_links = doc.xpath("//a").select {|link| link['href'] =~ /\.mp3$/ }
 mp3_links.each do |link|
   href = link['href']
   outname = File.basename(href)
   puts "Downloading: #{outname}"
   open(href) do |io|
     File.open(outname,'w') {|out| out.print(io.read) }
   end
 end
