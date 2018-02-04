require 'net/http'

class HttpClient
  @token

  def update_token(token)
    @token = token
  end

  def post(uri, params)
    check_uri(uri)
    req = Net::HTTP::Post.new(uri)
    req.body = params.to_json if params
    http_response(uri, req)
  end

  def get(uri, params)
    check_uri(uri)
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(uri)
    http_response(uri, req)
  end

  def check_uri(uri)
    raise ArgumentError.new('Uri cannot be nil') unless uri
  end

  def http_response(uri, req)
    return unless uri.hostname && uri.port
    Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
  end
end
