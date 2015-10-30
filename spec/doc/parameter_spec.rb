require 'spec_helper'

RSpec.describe Grape::App::Doc::Parameter do
  subject { described_class.new :name, type: "String", required: true }

  its(:name) { is_expected.to eq("name") }
  its(:desc) { is_expected.to eq("") }
  its(:doc) { is_expected.to eq({}) }
  its(:type) { is_expected.to eq("String") }
  its(:values) { is_expected.to eq([]) }
  its(:default) { is_expected.to be_nil }
  its(:required?) { is_expected.to be_truthy }

  it "should allow custom type documentation" do
    pm = described_class.new :name, type: "String", documentation: { type: "[DateTime]" }
    expect(pm.type).to eq("[DateTime]")
  end

  it "should normalize types" do
    pm = described_class.new :name, type: "[Integer]"
    expect(pm.type).to eq("[Integer]")

    pm = described_class.new :name, type: "BigDecimal"
    expect(pm.type).to eq("Decimal")

    pm = described_class.new :name, type: "Virtus::Attribute::Boolean"
    expect(pm.type).to eq("Boolean")

    pm = described_class.new :name, type: "[Axiom::Types::Decimal]"
    expect(pm.type).to eq("[Decimal]")
  end



end
