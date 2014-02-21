require 'mechanize'
require 'pp'

module PoemPoster
  def post_poem poem
    return if poem.empty?
    pplog_page = login()
    pplog_new_poem_page = pplog_page.link_with(href: '/my/posts/new').click

    pplog_new_poem_form = pplog_new_poem_page.forms.first
    pplog_new_poem_form.field_with(name: 'post[content]').value = poem
    pplog_new_poem_form.submit
    #pplog_page.back
  end

  def user_name
    YAML.load_file('login.yml')['user_name']
  end

  def password
    YAML.load_file('login.yml')['password']
  end

  def login
    a = Mechanize.new
    user_name = user_name()
    password  = password()
    # request login page
    url = 'https://www.pplog.net/users/auth/twitter'
    page = a.get(url)

    # submitting login info
    tw_auth_form = page.forms.first
    tw_auth_form.field_with(name: 'session[username_or_email]').value = user_name
    tw_auth_form.field_with(name: 'session[password]').value = password
    submit_button = tw_auth_form.buttons.first
    tw_auth_confirm_page = tw_auth_form.submit(submit_button)
    # allow authorize
    pplog_page = tw_auth_confirm_page.link_with(text: 'click here to continue').click
    raise 'Login Failed' if pplog_page.nil?
    return pplog_page
  end
end
