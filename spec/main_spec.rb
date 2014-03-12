require 'spec_helper'
require_relative '../main'


describe "PPLogQueue" do
  include Rack::Test::Methods

  def app
    PPLogQueue.new
  end

  before {
    Post.all.each{|x| x.destroy}
  }
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
      before {
        post '/create', params = {
          body: post_body
        }
      }
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
    context "when id not found" do
      it "response is not nil" do
        post '/post', params = {
          id: post_id
        }
        expect(last_response).not_to be_nil
      end
    end
    context 'when id found' do
      it 'response it not nil' do
        post_id = Post.create(body: 'foo').id
        post '/post', params = {
          id: post_id
        }
        expect(last_response).not_to be_nil
      end
    end
  end
  after {
    Post.all.each{|x| x.destroy}
  }
end
