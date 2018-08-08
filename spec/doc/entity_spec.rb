require 'spec_helper'

RSpec.describe Grape::App::Doc::Entity do

  subject { described_class.new Post::Entity, described_class::Registry.new }

  its(:name) { is_expected.to eq("Post") }
  its(:desc) { is_expected.to eq("") }
  its(:uid) { is_expected.to match(/post-\d+/) }

  it "should parse attributes" do
    expect(subject.attributes.size).to eq(5)
    expect(subject.attributes[0]).to be_instance_of(Grape::App::Doc::Attribute)
  end

end
