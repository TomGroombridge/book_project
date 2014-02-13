require 'hmac'
require 'hmac-sha2'

class AmazonBookFetcher

  ACCESS_IDENTIFIER = 'AKIAJIT2TOCWJOPENM7Q'
  SECRET_IDENTIFIER = Rails.application.secrets.s3_secret

  AMAZON_ENDPOINT = 'http://webservices.amazon.co.uk/onca/xml'

  def search(title)
    params = sign_request search_params(title)
    response = fetch_response(params)


    parse_response(response)    
  end

  private

  def search_params(title_and_author)
    title, author = title_and_author.split(" by ")
      
    {
      'Service' => 'AWSECommerceService',
      'AWSAccessKeyId' => 'AKIAJIT2TOCWJOPENM7Q',
      'AssociateTag' => 'www.chrishillio-20',
      'Operation'=> 'ItemSearch',
      'SearchIndex' => 'Books',
      # 'Power' => 'title:To%20Kill%20A%20Mockingbird%20and%20author:Harper%20Lee', 
      # 'Power' => 'title:Harry%20Potter%20and%20author:Rowling',
      'Power' => URI.escape("title:#{title} and author:#{author}"),
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
    books = parsed["ItemSearchResponse"]["Items"]["Item"].first(3) rescue nil
    return false unless books
    
    books.map do |book|

      book_details = {}
      next unless book["LargeImage"]

      %w(Title NumberOfPages).each do |key|
        book_details[key.underscore] = book["ItemAttributes"][key]
      end

      %w(SalesRank DetailPageURL).each do |key|
        book_details[key.underscore] = book[key]
      end

      book_details['thumbnail'] = book["SmallImage"]["URL"]
      book_details['asin'] = book["ASIN"]
      book_details['image_url'] = book["LargeImage"]["URL"]
      book_details['author'] = [*book["ItemAttributes"]["Author"]].join(" and ")
      book_details['content'] = content_for(book)
      book_details

    end
  end 

  def content_for(book)
    content = ''
    begin 
      content = book["EditorialReviews"]["EditorialReview"]["Content"]
    rescue
      begin
        content = book["EditorialReviews"]["EditorialReview"].map{|review| review['Content']}.join(', ')    
      rescue Exception => e
        content = "No Description"
      end
    end
  end
end