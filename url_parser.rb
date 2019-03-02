class UrlParser
attr_reader :scheme, :fragment_id, :query_string, :path, :port, :domain

  def initialize(url)
    @scheme = url.split(':/')[0]


  unless url.split('#').length == 1
    @fragment_id = url.split('#')[-1]
    url = url.chomp! '#' + @fragment_id
  end

  unless url.split('?').length ==  1
    query = url.split('?')[-1]
    url = url.chomp! '?' + query

    @query_string = {}
    pairs = query.split('&')
    pairs.each do |pair|
      pair = pair.split('=')
      @query_string[pair[0]] = pair[1]
    end
  end

  @path = url.split('/').length > 3 ? url.split('/')[-1] : nil
  url = !@path.nil? ? (url.chomp! '/' + @path) : url

  if url.split(':')[-1].length < 6
    @port = url.split(':')[-1]
    url = url.chomp! ':' + @port
  elsif @scheme == 'http'
    @port = '80'
  elsif @scheme ='https'
    @port = '443'
  end

  @domain = url.split('//')[-1].chomp '/'

  end
end

p url = UrlParser.new("http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat")

p short_url = UrlParser.new("http://www.google.com/?q=cat#img=FunnyCat")

p no_port = UrlParser.new("https://www.google.com/search")
