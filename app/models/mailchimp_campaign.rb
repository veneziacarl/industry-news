class MailchimpCampaign
  def initialize(list_id, newsletter, body_content)
    @list_id = list_id
    @newsletter = newsletter
    @body_content = body_content
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
  end

  def create
    recipients = {
      list_id: @list_id,
    }

    settings = {
      subject_line: "#{@newsletter.title} - #{@newsletter.newsletter_date}",
      title: "Newsletter Campaign #{Date.today}",
      from_name: "#{ENV['FROM_NAME']}",
      reply_to: "#{ENV['FROM_EMAIL']}"
    }

    body = {
      type: "regular",
      recipients: recipients,
      settings: settings
    }

    begin
      @gibbon.campaigns.create(body: body)
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
    end
  end

  def make_body
    body = {
      template: {
        id: ENV['MAILCHIMP_TEMPLATE_ID'].to_i,
        sections: {
          "std_content00": @body_content
        }
      }
    }
  end

  def add_body_to_campaign(campaign_id)
    @gibbon.campaigns(campaign_id).content.upsert(body: make_body)
  end
end
