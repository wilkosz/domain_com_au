require 'domain_com_au/constants'
require 'json'

module DomainListing

  def self.index(http_client, type='residential', params={})
    url = "#{Constants::BASE_API_URL}/listings/#{type}/_search"
    uri = URI(url)
    check_response_and_return(http_client.post(uri,params))
  end

  def self.show(http_client, id)
    url = "#{Constants::BASE_API_URL}/listings/#{id}"
    uri = URI(url)
    check_response_and_return(http_client.get(uri))
  end

  private

  def self.check_response_and_return(res)
    raise StandardError.new("domain.com.au error: res.code #{res.code}, with res.body #{res.body}") unless res.code && res.body
    JSON.parse(res.body)
  end
end
