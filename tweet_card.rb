# require 'twitter'

# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "O9gmAB9UX3iLjch4KNygg"
#   config.consumer_secret     = "JaS2R7TLvJCARLv2priUHtaWSbyFynOuC7vgNTczCE"
#   config.access_token        = "37346709-Y9klZbysIfVhXpgiNnSxOtO8VM9i2p2vjNEchRd0t"
#   config.access_token_secret = "7Tuc3RRwhNw0w9a023XgwMgbAx9Eb13GEr0FMABfE"
# end

# tweet = client.search("http://chrishillonline.herokuapp.com/").first


# embed = Twitter::OEmbed.new id: tweet.id

# puts embed.inspect