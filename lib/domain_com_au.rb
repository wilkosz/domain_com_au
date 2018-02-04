require "domain_com_au/version"
require "domain_com_au/constants"
require "domain_com_au/http_client"
require "domain_com_au/client"

module DomainComAu
  def self.create_client(client_id=nil, client_secret=nil)
    raise ArgumentError.new('Client ID and Client Secret not provided') unless client_id && client_secret
    Client.new(client_id, client_secret)
  end
end
