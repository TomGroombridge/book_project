require 'hmac'
require 'hmac-sha2'

class AmazonBookFetcher

  ACCESS_IDENTIFIER = 'AKIAJDSSWRQYZB7YML4Q'
  SECRET_IDENTIFIER = Rails.application.secrets.s3_secret

  AMAZON_ENDPOINT = 'http://webservices.amazon.co.uk/onca/xml'

  def search(title)
    params = sign_request search_params(title)
    # raise params.inspect
    response = fetch_response(params)

    parse_response(response)    
  end

  private

  def search_params(title)
    {
      'Service' => 'AWSECommerceService',
      'AWSAccessKeyId' => 'AKIAJDSSWRQYZB7YML4Q',
      'AssociateTag' => 'www.chrishillio-20',
      'Operation'=> 'ItemSearch',
      'SearchIndex' => 'Books',
      # 'Power' => 'title:To%20Kill%20A%20Mockingbird%20and%20author:Harper%20Lee', 
      # 'Power' => 'title:Harry%20Potter%20and%20author:Rowling',
      'Power' => URI.escape("title:#{title}"),
      # 'Title' => 'Outliers',
      'Sort' => 'salesrank',  
      # 'Keywords' => URI.escape('To Kill A Mockingbird'),
      # 'Author' => URI.escape('Jane Austen'),
      'ResponseGroup' => 'Medium',
      'SignatureMethod' => 'HmacSHA256',
      'SignatureVersion' => 2,
      'Timestamp' => Time.now.iso8601
    }
  end

  def sign_request(params)
    # raise params.inspect
    canonical_querystring = params.sort.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
    string_to_sign = ["GET", "webservices.amazon.co.uk", "/onca/xml", canonical_querystring].join("\n")
    hmac = HMAC::SHA256.new(SECRET_IDENTIFIER)
    hmac.update(string_to_sign)
    signature = Base64.encode64(hmac.digest).chomp # chomp is important!

    params['Signature'] = signature
    return params
  end

  def fetch_response(params)
    querystring = params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&') # order doesn't matter for the actual request
    response = HTTParty.get("#{AMAZON_ENDPOINT}?#{querystring}")
  end

  def parse_response(response)
    parsed = Nori.new.parse(response.body)
    books = parsed["ItemSearchResponse"]["Items"]["Item"].first(3)

    books.map do |book|

      book_details = {}
      # raise book.inspect


      %w(Title Author NumberOfPages).each do |key|
        book_details[key.underscore] = book["ItemAttributes"][key]
      end

      %w(SalesRank DetailPageURL).each do |key|
        book_details[key.underscore] = book[key]
      end

      book_details ['thumbnail'] = book["SmallImage"]["URL"]
      book_details['image_url'] = book["LargeImage"]["URL"]
      book_details['content'] = book["EditorialReviews"]["EditorialReview"]["Content"] rescue "No description"

      book_details

    end
  end 
end