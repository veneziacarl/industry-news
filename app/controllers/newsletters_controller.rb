class NewslettersController < ApplicationController
  before_action :authorize_user, except: [:index]

  def index
    @newsletters = Newsletter.all.order('newsletter_date desc')
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    @newsletter.title = newsletter_params[:title]
    @newsletter.description = newsletter_params[:description]

    if @newsletter.save
      newsletter_article_ids = @newsletter.newsletter_article_ids
      send_array = newsletter_params[:articles_to_send].map { |id| id.to_i } - [0]
      new_send_array = send_array - @newsletter.articles_to_send
      remove_array = newsletter_article_ids - send_array
      new_remove_array = remove_array - (newsletter_article_ids - @newsletter.articles_to_send)

      new_remove_array.each do |newsletter_article_id|
        newsletter_article = NewsletterArticle.find(newsletter_article_id)
        newsletter_article.update(send_article: 'false')
      end

      new_send_array.each do |newsletter_article_id|
        newsletter_article = NewsletterArticle.find(newsletter_article_id)
        newsletter_article.update(send_article: 'true')
      end

      flash[:notice] = 'Update successful'
      redirect_to (:back)
    else
      flash[:error] = 'Invalid information supplied'
      redirect_to (:back)
    end
  end

  def send_newsletter
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])

    @newsletter = Newsletter.find(params[:newsletter_id])
    @articles = @newsletter.articles_to_send.map { |article_id| Article.find(article_id) }

    body_content = render_to_string(partial: 'newsletter_mailer/newsletter', locals: { newsletter: @newsletter, articles: @articles })

    mailchimp_campaign = MailchimpCampaign.new(ENV['MAILCHIMP_LIST_ID'], body_content)
    campaign = mailchimp_campaign.create

    mailchimp_campaign.add_body_to_campaign(campaign['id'])

    gibbon.campaigns(campaign['id']).actions.send.create

    flash[:notice] = 'think it worked...'
    redirect_to :back
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:title, :description, articles_to_send: [])
  end

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      flash[:error] = 'Access denied.'
      redirect_to root_path
    end
  end
end
