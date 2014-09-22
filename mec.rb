require 'mechanize'
require 'pp'

module PoemPoster
  def post_poem(poem)
    return if poem.empty?
    new_post_form = get_post_new_page.forms.first
    new_post_form.field_with(name: 'post[content]').value = poem

    new_post_form.submit
  end

  def get_post_new_page
    pplog_home_page = get_pplog_home_page
    new_poem_page = pplog_home_page.link_with(href: '/my/posts/new').click
  end

  def user_name
    fail 'user name was not set.' if ENV['PPLOG_USER_NAME'].nil?
    ENV['PPLOG_USER_NAME']
  end

  def password
    fail 'password was not set.' if ENV['PPLOG_USER_PASSWORD'].nil?
    ENV['PPLOG_USER_PASSWORD']
  end

  def get_pplog_home_page # 1 -> access_twitter_page
    # Run authorize
    access_twitter_page
    login_to_twitter
    pass_confirmation

    @pplog_home_page
  end

  def access_twitter_page # 2 -> login_to_twitter
    a = Mechanize.new
    # request login page
    url = 'https://www.pplog.net/users/auth/twitter'
    @twitter_page = a.get(url)
  end

  def login_to_twitter # 3 -> pass_confirmation
    # submitting login info
    auth_form = fillup_auth_form
    submit_auth_form(fillup_auth_form)
    auth_form
  end

  def fillup_auth_form
    auth_form = @twitter_page.forms.first
    auth_form.field_with(name: 'session[username_or_email]').value = user_name
    auth_form.field_with(name: 'session[password]').value = password
    auth_form
  end

  def submit_auth_form(auth_form)
    submit_button = auth_form.buttons.first
    @auth_confirm_page = auth_form.submit(submit_button)
  end

  def pass_confirmation # 4 -> return pplog_page
    # allow authorize
    pplog_page =
      @auth_confirm_page.link_with(text: 'click here to continue').click
    fail 'Login Failed' if pplog_page.nil?

    @pplog_home_page = pplog_page
  end
end
