# https://rapidapi.com/developer/security/default-application_4781561

# require 'uri'
require 'net/http'
require 'openssl'

def api_key
  file = File.open("#{__dir__}/security/rapidAPI/api-key")
  apikey = file.readlines
  file.close
  apikey.sample.chomp
end

def write_data(filename, response_data)
  File.write("#{__dir__}/data/#{filename}", response_data)
end

def http(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http
end

def request(url, api_key)
  request = Net::HTTP::Get.new(url)
  request['x-rapidapi-host'] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
  request['x-rapidapi-key'] = api_key
  request
end

url = URI('https://rapidapi.p.rapidapi.com/stock/v2/get-recommendations?symbol=INTC')
http = http(url)
api_key = api_key
request = request(url, api_key)
response = http.request(request)

write_data('get-recommendations?symbol=INTC', response.read_body)
