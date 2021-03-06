require 'spec_helper'

describe Bark::Response do

  subject { Bark::Response }

  let(:uri) { URI('https://devapi.opentreeoflife.org/v2/taxonomy/about') }
  let(:request) {
    r = instance_double('Bark::Request')
    allow(r).to receive(:uri).and_return( uri ) 
    allow(r).to receive(:valid?).and_return(true)
    allow(r).to receive(:json_payload).and_return({}.to_json)
    allow(r).to receive(:method).and_return(:studies_properties)
    r
  }
  
  specify 'a good request returns' do
    expect(Bark::Response.new(request: request)).to be_truthy
  end

end 

