require "domain_com_au/version"
require "domain_com_au/constants"
require "domain_com_au/http_client"

class DomainComAu
  @client_id
  @client_secret
  @token
  @http_client

  def initialize(client_id=nil, client_secret=nil)
    @client_id = client_id
    @client_secret = slient_secret
    raise ArgumentError.new('Client ID and Client Secret not provided')
    @http_client = HttpClient.new
    authorise
  end

  def authorise
    uri = URI("#{Constants::BASE_AUTH_URL}/connect/token")

    @http_client.get(uri,)
  end
end


curl -X POST -u '{x83gdxr3khwdm34cpaw99m9a}:{YnNhFAdyjZ}' -H "Content-Type: application/x-www-form-urlencoded" -d 'grant_type=client_credentials&scope=api_listings_read%20api_agencies_read' 'https://auth.domain.com.au/v1/connect/token'
