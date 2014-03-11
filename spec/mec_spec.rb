require 'spec_helper'
require_relative '../mec'

RSpec.configure do |config|
  config.include PoemPoster
end

describe PoemPoster do
  let(:dummyclass){Class.new {include PoemPoster}}
  context 'when load user info' do
    it 'is user_name as "your_user_name"' do
      expect(user_name).to eq 'your_user_name'
    end
    it 'is password as "your_password"' do
      expect(password).to eq 'your_password'
    end
  end

  describe "getting pplog logged-in page" do
    before {
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
    }
    context 'when get twitter authorize page' do
      it {
        expect(access_twitter_page).not_to be_nil
      }
      it 'url is access_twitter_page' do
        expect(access_twitter_page.uri.to_s).to eq 'https://www.pplog.net/users/auth/twitter'
      end
    end

    context "when filledup auth form" do
      before {
        access_twitter_page
      }
      it {
        expect(fillup_auth_form).not_to be_nil
      }
      it 'form action' do
        action = fillup_auth_form.action
        expect(action).to eq 'https://api.twitter.com/oauth/authorize'
      end
      it 'username_or_email field is not empty' do
        value = fillup_auth_form.field_with(name: 'session[username_or_email]').value
        expect(value).not_to be_empty
      end
      it 'password field is not empty' do
        value = fillup_auth_form.field_with(name: 'session[password]').value
        expect(value).not_to be_empty
      end
    end

    context "when passed auth form submit " do
      before {
        access_twitter_page
      }
      subject { submit_auth_form(fillup_auth_form) }
      it "returns page" do
        expect(subject.instance_of?(Mechanize::Page)).to be_true
      end
      it 'page has form' do
        form = submit_auth_form(fillup_auth_form).forms.count
        expect(form).not_to eq 0
        expect(form).to eq 1
      end
      it 'page has link' do
        page = submit_auth_form(fillup_auth_form)
        link = page.links.count
        expect(link).to eq 1
      end
      it 'link text is "click here to continue"' do
        page = submit_auth_form(fillup_auth_form)
        page.links
        link = page.link_with(text: 'click here to continue')
        expect(link).not_to be_nil
      end
    end
    context "when passed confirm authorize page" do
      before {
        access_twitter_page
        login_to_twitter
      }
      it {
        expect(pass_confirmation).not_to be_nil
      }
      it 'is pplog callback url' do
        url = pass_confirmation.uri.to_s
        expect(url).to eq @pplog_callback_page
      end
    end
    context "when get pplog post new page" do
      it {
        expect(get_post_new_page).not_to be_nil
      }
      it "has a form" do
        form = get_post_new_page.forms.count
        expect(form).not_to eq 0
        expect(form).to eq 1
        expect(form).not_to eq 2
      end
    end
    context 'when posting poem' do
      it {
        page = post_poem('ぽえみ')
        expect(page).not_to be_nil
      }
      it 'will get Argument Error' do
        #return_data = post_poem()
        expect{post_poem()}.to raise_error(ArgumentError, 'wrong number of arguments (0 for 1)')
      end
      it 'will get nil' do
        return_data = post_poem('')
        expect(return_data).to be_nil
      end
    end
  end
  after {
    FakeWeb.allow_net_connect = false
  }
end

