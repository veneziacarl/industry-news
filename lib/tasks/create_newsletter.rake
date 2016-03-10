require 'rss'

desc 'pull daily articles from feeds and make newsletter'
task create_newsletter: :environment do
  today = Date.today
  newsletter = Newsletter.find_or_create_by(newsletter_date: today, title: 'Default Title')

  pull_news(today, newsletter)

  NewsletterMailer.mail_newsletter(Contact.all, newsletter).deliver_now
end

def pull_news(date, newsletter)
  NewsletterFeed.all.each do |feed|
    puts feed.id
    rss = RSS::Parser.parse(feed.url, false)
    rss.items.each do |item|
      if feed.url.match(/feedburner/)
        if item.date == nil
          if item.dc_date >= date
            article = Article.find_or_create_by(article_date: date, title: item.title, url: item.link, newsletter_feed: feed)
          end
        elsif item.date >= date
          article = Article.find_or_create_by(article_date: date, title: item.title, url: item.link, description: item.description, newsletter_feed: feed)
        end
      elsif item.date >= date
        article = Article.find_or_create_by(article_date: date, title: item.title, url: item.link, description: item.description, newsletter_feed: feed)
      end
      NewsletterArticle.find_or_create_by(newsletter: newsletter, article: article)
    end
  end
end
