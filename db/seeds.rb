FEEDS = [
  { name: "Invest In Cannabis", link: "http://www.investincannabis.com/feed/" },
  { name: "Marijuana Venture", link: "http://www.marijuanaventure.com/feed/" },
  { name: "The Daily Chronic", link: "http://www.thedailychronic.net/feed/" },
  { name: "Marijuana Business Daily", link: "http://mjbizdaily.com/feed/" },
  { name: "High Times", link: "https://feeds.feedburner.com/HIGHTIMESMagazine" },
  { name: "Cannabis Business Times", link: "http://www.cannabisbusinesstimes.com/rss" },
  { name: "Marijuana Stocks", link: "http://marijuanastocks.com/feed/" },
  { name: "Weed Worthy", link: "https://feeds.feedburner.com/Weedworthy-TodaysCannabisNewsNetwork" },
  { name: "Cannabis Culture", link: "http://www.cannabisculture.com/feed" },
  { name: "Investing News - Cannabis", link: "http://investingnews.com/category/daily/resource-investing/agriculture-investing/cannabis-investing/feed/" },
  { name: "The Weed Blog", link: "https://feeds.feedburner.com/TheWeedBlogcom" },
  { name: "Dope Magazine", link: "http://www.dopemagazine.com/feed/" },
  { name: "New Cannabis Ventures", link: "https://www.newcannabisventures.com/feed/" },
  # { name: "Ganjapreneur", link: "http://www.ganjapreneur.com/feed/" },
  { name: "Cannabis-Chronicles", link: "http://cannabis-chronicles.com/feed/" },
  { name: "Cashinbis", link: "https://feeds.feedburner.com/cashinbis" },
  { name: "Marijuana", link: "http://www.marijuana.com/feed/" }
]

FEEDS.each do |feed|
  NewsletterFeed.find_or_create_by(feed_name: feed[:name], url: feed[:link])
end

User.find_or_create_by(email: 'user@example.com') do |user|
  user.first_name = 'Test'
  user.last_name = 'User'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'admin'
end
