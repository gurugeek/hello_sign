require 'integration/helper'
require 'json'

describe HelloSign do
  context "when returning a response with a body" do
    before do
      stub_get_with_auth('/json')
        .to_return(
          headers: {'Content-Type' => 'application/json'},
          body:    {account_id: 1}.to_json
        )
    end

    it "parses the body into a hash with symbols as keys" do
      expect(HelloSign.client.get('/json')).to eq({account_id: 1})
    end
  end

  describe "#get" do
    before { stub_get_with_auth('/resource') }

    example do
      HelloSign.client.get('/resource')
      expect(a_get_with_auth('/resource')).to have_been_made
    end

    example do
      HelloSign.client.get('/resource')
      headers = {'User-Agent' => "hello_sign gem v#{HelloSign::VERSION}"}
      expect(a_get_with_auth('/resource').with(headers: headers)).to have_been_made
    end
  end

  describe "#post" do
    before { stub_post_with_auth('/resource') }

    example do
      HelloSign.client.post('/resource')
      expect(a_post_with_auth('/resource')).to have_been_made
    end
  end
end
