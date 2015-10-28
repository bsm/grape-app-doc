require 'erb'

module Grape::App::Doc

  def self.generate(host, api = Grape::App)
    Grape::App::Doc::Document.new(host, api).output
  end

end

%w|
renderable
attribute
document
endpoint
entity
header
parameter
version
|.each do |name|
  require "grape/app/doc/#{name}"
end
