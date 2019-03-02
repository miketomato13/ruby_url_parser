require './url_parser.rb'

describe UrlParser do
  context 'with all parts' do
    before(:each) do
      @new_url = UrlParser.new "http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat"
    end

    it 'when instantiated should be a member of the UrlParser class' do
      expect(@new_url).to be_a UrlParser
    end

    it 'should have a scheme attribute' do
      expect(@new_url.scheme).to eq("http")
    end

    it 'should have a domain attribute' do
      expect(@new_url.domain).to eq("www.google.com")
    end

    it 'should have a port attribute with the given port number' do
      expect(@new_url.port).to eq("60")
    end

    it 'should have a path attribute' do
      expect(@new_url.path).to eq("search")
    end

    it 'should have a query string attribute that should return a hash of query params' do
      expect(@new_url.query_string).to be_a(Hash)
      expect(@new_url.query_string).to eq({"q" => "cat", "name" => "Tim"})
    end

    it 'should have a fragment id attribute' do
      expect(@new_url.fragment_id).to eq("img=FunnyCat")
    end
  end

  context 'with no path' do
    before(:each) do
      @new_url = UrlParser.new "https://www.google.com/?q=cat#img=FunnyCat"
    end

    it 'should return a nil path' do
      expect(@new_url.path).to be(NIL)
    end

    it 'should be able to have a query string at the root path' do
      expect(@new_url.query_string).to eq({"q" => "cat"})
    end

    it 'should be able to have a fragment id at the root path' do
      expect(@new_url.fragment_id).to eq("img=FunnyCat")
    end
  end

  context 'with a special case' do
    it 'with no port number and a http scheme should default to port 80' do
      insecure_url = UrlParser.new "http://www.google.com/search"
      expect(insecure_url.port).to eq("80")
    end
    it 'with no port number and a https scheme should default to port 443' do
      secure_url = UrlParser.new "https://www.google.com/search"
      expect(secure_url.port).to eq("443")
    end
    it 'a query sting with duplicate params should only return one key value pair' do
      duplicate_param = UrlParser.new "http://www.google.com:60/search?q=cat&q=overwrite#img=FunnyCat"
      expect(duplicate_param.query_string).to eq({"q"=> "overwrite"})
    end
  end
end
