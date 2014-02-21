
require "selenium-webdriver"

profile = Selenium::WebDriver::Firefox::Profile.new
#You can use an existing profile as a template for the WebDriver profile by passing the profile name (see firefox -ProfileManager to set up custom profiles.) 	"%APPDATA%\Mozilla\" 
#driver = Selenium::WebDriver.for(:firefox, :profile => "my-existing-profile")
#If you want to use your default profile, pass :profile => "default"
#You can also get a Profile instance for an existing profile and tweak its preferences. This does not modify the existing profile, only the one used by WebDriver.
#default_profile = Selenium::WebDriver::Firefox::Profile.from_name "default"
#default_profile.native_events = true
#driver = Selenium::WebDriver.for(:firefox, :profile => default_profile)

profile['browser.download.folderList'] = 2 #custom location

profile['browser.download.dir'] = "C:\\Users\\jesser\\Desktop\\downloader\\dls"  #Oh my gosh, you have to put the slash twice stupid escaped. The examples do no do this!!!!!!!!!!!
#profile['browser.download.dir'] = "#{Dir.pwd}/downloads" # this will not work unless you use gsub
#profile['browser.download.LastDir'] = "#{Dir.pwd}/downloads" # this will not work unless you use gsub / to \\
profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv"
driver = Selenium::WebDriver.for :firefox, :profile => profile

driver.navigate.to "https://login.salesforce.com/?un=<@SF_USER_NAME>&pw=<@SF_PW>"  #ALERT - MUST USE SYSTEM VARIABLE HERE for un and pw THAT DOES NOT GO TO GIT HUB

#NEED TO FIGURE OUT HOW TO TELL THE FILES APART - try download time or file name or order in directory array sort
driver.navigate.to "https://na8.salesforce.com/00OC0000004uq5D?export=1&enc=UTF-8&xf=csv"   #Products Reports
driver.navigate.to "https://na8.salesforce.com/00OC0000004utG4?export=1&enc=UTF-8&xf=csv"   #Opps Reports
# Opps report https://na8.salesforce.com/00OC0000004utG4
puts "PRESS ENTER TO PROCEED -- All done did it work with out a delay?"
STDIN.gets()

driver.quit
