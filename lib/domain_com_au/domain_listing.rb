require 'domain_com_au/constants'

module DomainListing

  def self.index(http_client, type='residential', params={})
    url = "#{Constants::BASE_API_URL}/listings/#{type}/_search"
    uri = URI(url)
    http_client.post(uri,params)
  end

  def self.show(http_client, id)
    url = "#{Constants::BASE_API_URL}/listings/#{id}"
    uri = URI(url)
    http_client.get(uri)
  end
end
