require 'rss'

desc 'pull daily articles from feeds and make newsletter'
task create_newsletter: :environment do
  today = Date.today
  newsletter = Newsletter.find_or_create_by(newsletter_date: today, title: 'Default Title')
  @num_time_outs = 0
  @articles_skipped = 0
  times_run = 0
  time_out_tolerance = 0.1

  begin
    pull_news(today, newsletter)
    time_out_percentage = @num_time_outs / NewsletterFeed.count.to_f
    times_run += 1
  end while time_out_percentage > time_out_tolerance && times_run < 3
end

def pull_news(date, newsletter)
  date = date.prev_day
  NewsletterFeed.all.each do |feed|
    begin
      rss = RSS::Parser.parse(feed.url, false)
      rss.items.each do |item|
        if feed.url.match(/feedburner/)
          if item.date == nil
            if item.dc_date >= date
              article = Article.find_or_create_by!(article_date: date, title: item.title, url: item.link, newsletter_feed: feed)
            end
          elsif item.date >= date
            article = Article.find_or_create_by!(article_date: date, title: item.title, url: item.link, description: item.description, newsletter_feed: feed)
          end
        elsif item.date >= date
          article = Article.find_or_create_by!(article_date: date, title: item.title, url: item.link, description: item.description, newsletter_feed: feed)
        end

        if article.present?
          NewsletterArticle.find_or_create_by!(newsletter: newsletter, article: article)
        else
          @articles_skipped += 1
          puts "SKIPPED #{@articles_skipped}"
          puts "SKIPPED #{item.date || item.dc_date}\n\n"
        end
      end
      puts feed.id
    rescue
      puts "#{feed.id} timed out!"
      @num_time_outs += 1
      next
    end
  end
end
