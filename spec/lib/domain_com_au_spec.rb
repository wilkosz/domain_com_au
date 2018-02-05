client_id = "x83gdxr3khwdm34cpaw99m9a"
client_secret = "YnNhFAdyjZ"

RSpec.describe DomainComAu do
  it "has a version number" do
    expect(DomainComAu::VERSION).not_to be nil
  end

  it "generated success authentication token" do
    domain_client = DomainComAu.create_client(client_id, client_secret)
    expect(domain_client.get_token).not_to be nil
  end
  # it "generate listings" do
  #   listings = domain_client.search_listings(
  #     'residential',
  #     {
  #       'locations': [
  #         {
  #           'state':'NSW',
  #           'region':'',
  #           'area':'',
  #           'suburb':'',
  #           'postCode':'',
  #           'includeSurroundingSuburbs':false
  #         }
  #       ]
  #     }
  #   )
  #   expect(listings).not_to be nil
  # end
end
