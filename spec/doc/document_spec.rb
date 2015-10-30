require 'spec_helper'

RSpec.describe Grape::App::Doc::Document do

  it 'should parse endpoints' do
    expect(subject.endpoints.size).to eq(4)
    expect(subject.endpoints[0]).to be_instance_of(Grape::App::Doc::Endpoint)
  end

  it 'should parse entities' do
    expect(subject.entities.size).to eq(4)
    expect(subject.entities[0]).to be_instance_of(Grape::App::Doc::Entity)
  end

end
