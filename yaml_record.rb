require 'yaml_record'

# Manage user poem in YAML
class Post < YamlRecord::Base
  properties :body
  adapter :local
  source File.expand_path('./post')
end
