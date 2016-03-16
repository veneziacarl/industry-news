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
