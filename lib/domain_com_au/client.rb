require 'domain_com_au/http_client'
require 'domain_com_au/domain_listing'

class Client
  def initialize(client_id, client_secret)
    @http_client = HttpClient.new(client_id, client_secret)
  end

  def get_token
    @http_client.auth_token
  end

  def search_listings(type, params={})
    DomainListing.index(@http_client, type, params)
  end
end
