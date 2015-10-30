require 'spec_helper'

RSpec.describe Grape::App::Doc do

  it 'should parse the API' do
    expect(described_class.create).to be_instance_of(described_class::Document)
  end

end
