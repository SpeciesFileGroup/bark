require 'spec_helper'

describe Bark::Request::Studies do

  subject { Bark::Request::Studies }

  context 'Ruby/Bark specific implementation' do
    specify 'is written for an API_VERSION' do
      expect( Bark::Request::Studies::API_VERSION).to eq('v2')
    end

    specify 'has an SEARCH_BASE' do
      expect( Bark::Request::Studies::SEARCH_BASE).to eq('http://devapi.opentreeoflife.org/v2')
    end

    specify 'has an default FORMAT' do
      expect( Bark::Request::Studies::FORMAT).to eq('json')
    end

    specify 'reference methods by ot API wrapper shared name in METHODS' do 
      expect( Bark::Request::Studies::METHODS.keys.sort).to eq([:studies_find_studies, :studies_find_trees, :get_study, :get_study_tree, :studies_properties].sort)
    end

    context 'building a request URI' do
      specify 'for find_studies'  do
        a = Bark::Request::Studies.new(method: :studies_find_studies)
        expect(a.uri.to_s).to eq('http://devapi.opentreeoflife.org/v2/studies/find_studies')
      end

      specify 'for matched_studies' do
        a = Bark::Request::Studies.new(method: :studies_find_trees)
        expect(a.uri.to_s).to eq('http://devapi.opentreeoflife.org/v2/studies/find_trees')
      end

      specify 'for study' do
        id = 'pg_1144' 
        a = Bark::Request::Studies.new(method: :get_study, params: {study_id: id})
        expect(a.uri.to_s).to eq("http://devapi.opentreeoflife.org/v2/study/#{id}")
      end

      specify 'for study' do
        id = 'pg_1144' 
        tree = 'tree2324'
        a = Bark::Request::Studies.new(method: :get_study_tree, params: {study_id: id, tree_id: tree })
        expect(a.uri.to_s).to eq("http://devapi.opentreeoflife.org/v2/study/#{id}/tree/#{tree}")
      end
 

    end

    context 'payload' do
      specify 'params are persisted' do
        params = {value: 'Garcinia', property: 'ot:ottTaxonName'}
        a = Bark::Request::Studies.new(method: :studies_find_trees, params: params )
        expect(a.params).to eq(params)
        expect(a.json_payload).to eq(params.to_json)
        expect(a.valid?).to be(true)
      end

    end

    context 'basic use, for :studies_find_trees, in a response' do
      specify 'works' do
        a = Bark::Request::Studies.new(method: :studies_find_trees, params: {value: 'Garcinia', property: 'ot:ottTaxonName'})
        b = Bark::Response.new(request: a)
        expect(b.request_succeeded?).to be(true)
        expect(b.json.keys.include?('matched_studies')).to be(true)
      end
    end

    context 'shared tests' do
      run_tests(Bark::Request::Studies, SharedTestsHelper::SHARED_TESTS['studies'])
    end

  end
end 
