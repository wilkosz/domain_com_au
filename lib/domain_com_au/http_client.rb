require 'domain_com_au/constants'
require 'net/http'
require 'json'
require 'base64'
require 'time'

class HttpClient
  attr_accessor :auth_token

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    @headers = {
      'content-type': 'application/json'
    }
    authorize
  end

  def post(uri, params={}, headers={})
    authorize if @auth_token && is_token_expired?
    check_uri(uri)
    req = Net::HTTP::Post.new(uri)
    set_headers(req, headers)
    set_body(req, params)
    http_response(uri, req)
  end

  def get(uri, headers={})
    authorize if @auth_token && is_token_expired?
    check_uri(uri)
    req = Net::HTTP::Get.new(uri)
    set_headers(req, headers)
    http_response(uri, req)
  end

  private

  def is_token_expired?
    @auth_expiry - 60 <= Time.now # add request buffer
  end

  def check_uri(uri)
    raise ArgumentError.new('Uri cannot be nil') unless uri
  end

  def set_headers(req, headers)
    req['authorization'] = "#{@auth_type} #{@auth_token}" if @auth_token && @auth_type
    @headers.each { |key, value| req[key.to_s] = value }
    headers.each { |key, value| req[key.to_s] = value } if headers.class == Hash
  end

  def set_body(req, params)
    req.body = case req['content-type']
      when 'application/x-www-form-urlencoded' then
        URI.encode_www_form(params)
      when 'application/json' then
        params.to_json
      else nil
      end
  end

  def http_response(uri, req)
    return unless uri.hostname && uri.port
    Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
  end

  def authorize
    uri = URI("#{Constants::BASE_AUTH_URL}/connect/token")
    base_64_credentials = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
    params = {
      grant_type: "client_credentials",
      scope: "api_listings_read api_agencies_read"
    }
    headers = {
      'authorization': "basic #{base_64_credentials}",
      'content-type': "application/x-www-form-urlencoded"
    }
    time_now = Time.now
    res = post(uri, params, headers)
    if res.code && res.code.to_i == 200
      body = JSON.parse(res.body)
      @auth_token = body['access_token']
      @auth_type = body['token_type']
      @auth_expiry = time_now + body['expires_in']
    else
      raise ArgumentError.new("Domain Auth API didn't return a token, body: #{res.body}, status: #{res.code}")
    end
  end
end
