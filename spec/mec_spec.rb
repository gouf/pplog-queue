require 'spec_helper'
require_relative '../mec'

RSpec.configure do |config|
  config.include PoemPoster
end

describe 'PoemPoster' do
  it 'is user_name as "your_user_name"' do
    expect(user_name).to eq 'your_user_name'
  end
  it 'is password as "your_password"' do
    expect(password).to eq 'your_password'
  end
end

