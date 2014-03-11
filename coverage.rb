require 'json'

def covered_percent
  begin
    file = JSON.restore(File.read('coverage/.last_run.json'))
    covered_percent = file["result"]["covered_percent"]
    puts "code coverage persent: #{covered_percent}"
  rescue
    puts "Please run test before this command."
  end
end

print covered_percent
