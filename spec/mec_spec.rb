require 'spec_helper'
require_relative '../mec'
require 'dotenv'

Dotenv.load

RSpec.configure do |config|
  config.include PoemPoster
end

describe PoemPoster do
  let(:dummyclass){Class.new {include PoemPoster}}
  context 'when load user info' do
    it 'is user_name not empty"' do
      expect(user_name.class).to eq String
      expect(user_name.empty?).to be_falsey
    end
    it 'is password not empty' do
      expect(user_name.class).to eq String
      expect(user_name.empty?).to be_falsy
    end
  end

  describe "getting pplog logged-in page" do
    before do
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:get,
        (@auth_twitter = 'https://www.pplog.net/users/auth/twitter'),
        body: File.read('test_html/auth_twitter.html'),
        content_type: 'text/html'
      )
      FakeWeb.register_uri(:post,
        (@auth_twitter = 'https://api.twitter.com/oauth/authorize'),
        body: File.read('test_html/allow_auth_twitter.html'),
        content_type: 'text/html'
      )
      FakeWeb.register_uri(:get,
        (@pplog_callback_page = 'https://www.pplog.net/users/auth/twitter/callback?oauth_token=h?oauth_verifier=f'),
        body: File.read('test_html/pplog_home_loggedin.html'),
        content_type: 'text/html'
      )
      FakeWeb.register_uri(:get,
        (@pplog_post_new = 'https://www.pplog.net/my/posts/new'),
        body: File.read('test_html/pplog_home_loggedin.html'),
        content_type: 'text/html'
      )
      FakeWeb.register_uri(:get,
        (@pplog_post_new = 'https://www.pplog.net/my/posts/new'),
        body: File.read('test_html/pplog_post_new.html'),
        content_type: 'text/html'
      )
      FakeWeb.register_uri(:post,
        (@pplog_post_new = 'https://www.pplog.net/my/posts'),
        body: File.read('test_html/pplog_home_loggedin.html'),
        content_type: 'text/html'
      )
    end
    context 'when get twitter authorize page' do
      it do
        expect(access_twitter_page).not_to be_nil
      end
      it 'url is access_twitter_page' do
        expect(access_twitter_page.uri.to_s).to eq 'https://www.pplog.net/users/auth/twitter'
      end
    end

    context "when filledup auth form" do
      before do
        access_twitter_page
      end
      subject { fillup_auth_form }
      let(:username_field) do
        subject.field_with(name: 'session[username_or_email]').value
      end
      let(:password_field) do
        subject.field_with(name: 'session[username_or_email]').value
      end
      it do
        is_expected.not_to be_nil
      end
      it 'form action' do
        expect(subject.action).to eq @auth_twitter
      end
      it 'username_or_email field is not empty' do
        expect(username_field).not_to be_empty
      end
      it 'password field is not empty' do
        expect(password_field).not_to be_empty
      end
    end

    context "when passed auth form submit " do
      before do
        access_twitter_page
      end
      subject { submit_auth_form(fillup_auth_form) }
      it "returns page" do
        expect(subject.instance_of?(Mechanize::Page)).to be_truthy
      end
      it 'page has form' do
        form = subject.forms.count
        expect(form).not_to eq 0
        expect(form).to eq 1
      end
      it 'page has link' do
        link = subject.links.count
        expect(link).to eq 1
      end
      it 'link text is "click here to continue"' do
        link = subject.link_with(text: 'click here to continue')
        expect(link).not_to be_nil
        expect(link.instance_of?(Mechanize::Page::Link)).to be_truthy
      end
    end
    context "when passed confirm authorize page" do
      before do
        access_twitter_page
        login_to_twitter
      end
      subject { pass_confirmation }
      it do
        is_expected.not_to be_nil
      end
      it 'is pplog callback url' do
        url = subject.uri.to_s
        expect(url).to eq @pplog_callback_page
      end
    end
    context "when get pplog post new page" do
      subject { get_post_new_page }
      it do
        expect(subject).not_to be_nil
        expect(subject.instance_of?(Mechanize::Page)).to be_truthy
      end
      it "has a form" do
        form = subject.forms.count
        expect(form).not_to eq 0
        expect(form).to eq 1
        expect(form).not_to eq 2
      end
    end
    context 'when posting poem' do
      it do
        page = post_poem('ぽえみ')
        expect(page).not_to be_nil
      end
      it 'will get Argument Error' do
        message = 'wrong number of arguments (0 for 1)'
        expect{post_poem()}.to raise_error(ArgumentError, message)
      end
      it 'will get nil' do
        return_data = post_poem('')
        expect(return_data).to be_nil
      end
    end
  end
  after do
    FakeWeb.allow_net_connect = true
  end
end
