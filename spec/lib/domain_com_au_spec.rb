require 'pry'
client_id = "x83gdxr3khwdm34cpaw99m9a"
client_secret = "YnNhFAdyjZ"

RSpec.describe DomainComAu do
  domain_client = DomainComAu.create_client(client_id, client_secret)

  it "has a version number" do
    expect(DomainComAu::VERSION).not_to be nil
  end

  it "generated success authentication token" do
    expect(domain_client.get_token).not_to be nil
  end

  it "generate listings" do
    listings = domain_client.search_listings(
      'residential',
      {
        "locations":[
          {
            "postCode":"3000"
          }
        ],
        "page":1,
        "pageSize":20
      }
    )
    puts listings.body
    expect(listings).not_to be nil
  end
end
