require 'yaml_record'

class Post < YamlRecord::Base
  properties :body
  adapter :local
  source File.expand_path('./post')
end
