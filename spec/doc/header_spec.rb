require 'spec_helper'

RSpec.describe Grape::App::Doc::Header do
  subject { described_class.new :name, desc: "DESC", other: "custom" }

  its(:name) { is_expected.to eq("name") }
  its(:desc) { is_expected.to eq("DESC") }
  its(:opts) { is_expected.to be_instance_of(Hash) }
end
