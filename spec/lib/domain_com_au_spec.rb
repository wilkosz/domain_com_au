client_id = ""
client_secret = ""

RSpec.describe DomainComAu do

  it "has a version number" do
    expect(DomainComAu::VERSION).not_to be nil
  end

  it "has client_id and client_secret" do
    expect(client_id.empty?).not_to be true
    expect(client_secret.empty?).not_to be true
  end

  domain_client = DomainComAu.create_client(client_id, client_secret)
  listing_id = nil

  it "generated success authentication token" do
    expect(domain_client.get_token).not_to be nil
  end

  it "generate listings search" do
    results = domain_client.search_listings(
      'residential',
      {
        "propertyType": "Rent",
        "locations":[
          {
            "postCode":"3000"
          }
        ],
        "page":1,
        "pageSize":2
      }
    )
    listing_id = results[0]['listings'] ?
      results[0]['listings'][0]['id'] :
      results[0]['listing']['id']
    expect(results).not_to be_empty
  end

  it "generate listing show" do
    listing = domain_client.show_listing(listing_id)
    expect(listing).not_to be nil
  end
end
