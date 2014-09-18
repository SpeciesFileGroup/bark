require 'spec_helper'

describe Bark::Request do

  let(:request) {Bark::Request.new}

  context 'attributes include' do
    specify '#payload' do
      expect(request).to respond_to(:payload)  
    end
  end

  context 'constants include' do
    specify 'BASE_URL' do
      expect( Bark::Request::BASE_URL).to eq('http://devapi.opentreeoflife.org')
    end
  end

 end 

