require 'nokogiri'
require 'open-uri'

url = 'https://www.theskepticsguide.org/podcast/sgu'
doc = Nokogiri::HTML(open(url))

sgu_mp3s = doc.xpath("//a").select {|link| link['href'] =~ /\.mp3$/ }

sgu_mp3s.each do |link|
  xpathhref = link['href']
  sgu_episode = File.basename(xpathhref)
  if File.exists?(sgu_episode)
    puts "Skipping the download of #{sgu_episode}, it already exists!"
  else
    puts "Downloading: #{sgu_episode}"
    open(xpathhref) do |save|
      File.open(sgu_episode,'w') {|out| out.print(save.read) }
    end
  end
end