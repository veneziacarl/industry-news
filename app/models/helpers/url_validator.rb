module Helpers::UrlValidator
  def valid_url?
    uri = URI.parse(url)
    unless uri.kind_of?(URI::HTTP)
      errors.add(:url, 'is not a valid url')
    end
  rescue URI::InvalidURIError
    errors.add(:url, 'is not a valid url')
  end
end
