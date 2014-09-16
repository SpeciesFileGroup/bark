require 'spec_helper'

describe Bark::Request do

  subject { Bark::Request }

  it 'has a BASE_URL' do
    expect( Bark::Request::BASE_URL).to eq('http://devapi.opentreeoflife.org')
  end

end 

