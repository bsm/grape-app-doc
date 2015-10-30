require 'rspec'
require 'rspec/its'
require 'grape/app/doc'

require 'support/mock_entities'
require 'support/mock_api'

RSpec.configure do |c|

  c.before :each do
    allow(Kernel).to receive(:warn) do |m|
      fail(m)
    end
    Grape::App::Doc.class_variable_set(:@@increment, 0)
  end

end
