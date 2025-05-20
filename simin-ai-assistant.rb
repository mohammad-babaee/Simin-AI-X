# Copyright 2025, Mohammad Babaee
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'faraday'
require 'json'
require 'httparty'
require 'awesome_print'
require 'cli/ui'
require 'tty-box'
require 'highline/import'

header = '''

▄▖▄▖▖  ▖▄▖▖ ▖  ▄▖▄▖  ▄▖    ▘  ▗     ▗   ▌  ▄▖▖ ▄▖  ▖▖      ▘    
▚ ▐ ▛▖▞▌▐ ▛▖▌  ▌▌▐   ▌▌▛▘▛▘▌▛▘▜▘▀▌▛▌▜▘  ▌  ▌ ▌ ▐   ▌▌█▌▛▘▛▘▌▛▌▛▌
▄▌▟▖▌▝ ▌▟▖▌▝▌  ▛▌▟▖  ▛▌▄▌▄▌▌▄▌▐▖█▌▌▌▐▖  ▌  ▙▖▙▖▟▖  ▚▘▙▖▌ ▄▌▌▙▌▌▌
                                        ▘                             
'''

puts CLI::UI.fmt "{{green: #{header} }}"

puts CLI::UI.fmt "{{magenta: Разработчик : Мохаммад Бабаи | Developer : Mohammad Babaee}}"


API_KEY = "YOUR API KEY IS HERE"
URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{API_KEY}"

puts ("------------------------------------------------")

puts "Please Write Here , What's in your mind ?"

puts ("------------------------------------------------")

user_input = gets.chomp()

puts ("------------------------------------------------")

puts CLI::UI.fmt "{{cyan:> User Request Confirm : }} {{green: #{user_input} {{v}} }}"

puts ("------------------------------------------------")

CLI::UI::Progress.progress do |bar|
  100.times do
    sleep(0.05)
    bar.tick
  end
end

payload = {
  contents: [
    {
      parts: [
        { text: "#{user_input}" }
      ]
    }
  ]
}

response = HTTParty.post(URL, headers: { "Content-Type" => "application/json" }, body: payload.to_json)

json_data = JSON.parse(response.body)

if json_data["candidates"]
  clean_text = json_data["candidates"].map { |c| c["content"]["parts"].map { |p| p["text"] } }.flatten.join(" ")
else
  clean_text = "No valid text found in response."
end

puts ("\n")

def typewriter(text, speed = 0.05)
  text.each_char do |char|
    print char
    sleep(speed)
  end
  puts
end

typewriter(clean_text)