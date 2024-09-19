#!/usr/bin/env ruby
# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2018-2024, by Samuel Williams.
# Copyright, 2020, by Bruno Sutic.

require "async"
require "protocol/http/body/file"
require "async/http/internet"

Async do
	internet = Async::HTTP::Internet.new
	
	headers = [
		["accept", "text/plain"],
	]
	
	body = Protocol::HTTP::Body::File.open(File.join(__dir__, "data.txt"))
	
	response = internet.post("https://utopia-falcon-heroku.herokuapp.com/echo/index", headers, body)
	
	# response.read -> string
	# response.each {|chunk| ...}
	# response.close (forcefully ignore data)
	# body = response.finish (read and buffer response)
	response.save("echo.txt")
	
ensure
	internet.close
end
