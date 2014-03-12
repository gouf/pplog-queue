require 'spec_helper'
require_relative '../main'


describe "PPLogQueue" do
  include Rack::Test::Methods

  def app
    PPLogQueue.new
  end

  before {
    Post.all.each{|x| x.destroy}
    FakeWeb.allow_net_connect = false
  }
  describe "Response Test" do
    before { get '/' }
    context "when accessing '/'" do
      it "get OK" do
        expect(last_response).to be_ok
      end
    end
  end
  after {
    Post.all.each{|x| x.destroy}
    FakeWeb.allow_net_connect = true
  }
end
