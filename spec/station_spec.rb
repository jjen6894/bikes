require 'rspec'
require_relative '../app/station'


describe Station do

  subject {described_class.new(1, "Old Street")}

  it 'knows its name' do
    expect(subject.name).to eq("Old Street")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(1)
  end
end
