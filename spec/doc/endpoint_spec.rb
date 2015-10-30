require 'spec_helper'

RSpec.describe Grape::App::Doc::Endpoint do

  let :route do
    Grape::Route.new \
      version: "v2015",
      prefix: "/api",
      namespace: "/",
      path: "/:version/something(.:format)",
      headers: { XAdminToken: { description: "Valdates your identity", required: true }},
      params:  {"id"=>"", "title"=>{:required=>true, :documentation=>{:desc=>"A title"}}}
  end

  subject { described_class.new route, Grape::App::Doc::Entity::Registry.new }

  it 'should parse routes with defaults' do
    expect(subject.method).to eq('GET')
  end

  it 'should parse success/failures' do
    expect(subject.success).to be_instance_of(described_class::Status)
    expect(subject.success.code).to eq(200)
    expect(subject.failure).to eq([])
  end

  it 'should parse headers' do
    expect(subject.headers.size).to eq(1)
    expect(subject.headers[0]).to be_instance_of(Grape::App::Doc::Header)
  end

  it 'should parse params' do
    expect(subject.params.size).to eq(1)
    expect(subject.params[0]).to be_instance_of(Grape::App::Doc::Parameter)
  end

end
