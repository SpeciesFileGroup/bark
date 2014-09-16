require 'spec_helper'

describe Bark::Request::Studies do

  subject { Bark::Request::Studies }

  it 'has an INTERFACE' do
    expect( Bark::Request::Studies::INTERFACE).to eq('studies')
  end

  it 'has an API_VERSION' do
    expect( Bark::Request::Studies::API_VERSION).to eq('v2')
  end

  # This becomes less useful in the new framework
  it 'has an SEARCH_BASE' do
    expect( Bark::Request::Studies::SEARCH_BASE).to eq('http://devapi.opentreeoflife.org/v2/studies')
  end

  it 'builds a find_studies url' do
    a = Bark::Request::Studies.new(method: :find_studies)
    expect(a.search_url).to eq('http://devapi.opentreeoflife.org/v2/studies/find_studies')
  end

  it 'returns a list of studies' do
    a = Bark::Request::Studies.new(method: :find_studies)
    expect(Bark::Response.new(request: a).json).to eq([])
  end

end 
