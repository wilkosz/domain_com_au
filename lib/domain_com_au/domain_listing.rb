require 'domain_com_au/constants'

module DomainListing

  def index(http_client, type='residential', params={})
    url = "#{DomainComAu::Constants.BASE_API_URL}/listings/#{type}/_search"
    uri = URI(url)
    http_client.post(uri,params)
  end

  def show(http_client, id)
    url = "#{DomainComAu::Constants.BASE_API_URL}/listings/#{id}"
    uri = URI(url)
    http_client.get(uri)
  end
end
