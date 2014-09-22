require 'spec_helper'
require_relative '../main'


describe "PPLogQueue" do
  include Rack::Test::Methods
  let(:dummyclass){Class.new {include PoemPoster}}

  def app
    PPLogQueue.new
  end

  before do
    Post.all.each{|x| x.destroy}
    FakeWeb.allow_net_connect = false
  end
  describe "Response Test" do
    before { get '/' }
    context "when accessing '/'" do
      it "get OK" do
        expect(last_response).to be_ok
      end
      subject {last_response.body}
      it "is HTML page" do
        expect(subject).to be_include('ぽすと')
        expect(subject).to be_include('textarea')
        expect(subject).to be_include('submit')
      end
    end
  end
  describe "Create new poem" do
    context "when post" do
      let(:post_body) { 'ぽぽぽ' }
      before do
        post '/create', params = {
          body: post_body
        }
      end
      it 'record is not empty' do
        expect(Post.all.count).to_not eq 0
      end
      it 'record count is 1' do
        expect(Post.all.count).to eq 1
      end
      it 'record count is not 2' do
        expect(Post.all.count).not_to eq 2
      end
      it "HTML includes posted body" do
        get '/'
        expect(last_response.body).to be_include(post_body)
      end
    end
  end
  describe "Post to pplog" do
    let(:post_id) { 12345.to_s }
  end
  after do
    Post.all.each{|x| x.destroy}
    FakeWeb.allow_net_connect = true
  end
end
