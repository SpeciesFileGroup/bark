require 'spec_helper'

describe Bark::Request::GraphOfLife do

 #context 'Ruby/Bark specific implementation' do
 #  specify 'is written for an API_VERSION' do
 #    expect( Bark::Request::TreeOfLife::API_VERSION).to eq('v2')
 #  end

 #  specify 'has an SEARCH_BASE' do
 #    expect( Bark::Request::TreeOfLife::SEARCH_BASE).to eq('https://devapi.opentreeoflife.org/v2/tree_of_life')
 #  end

 #  specify 'reference methods by ot API wrapper shared name in METHODS' do 
 #    expect( Bark::Request::TreeOfLife::METHODS.keys.sort).to eq(%i{tol_about tol_mrca tol_subtree tol_induced_tree}.sort)
 #  end

 #  context 'building a request URI' do
 #    specify 'for find_tree_of_life'  do
 #      a = Bark::Request::TreeOfLife.new(method: :tol_about)
 #      expect(a.uri.to_s).to eq('https://devapi.opentreeoflife.org/v2/tree_of_life/about')
 #    end

 #    specify 'for matched_tree_of_life' do
 #      a = Bark::Request::TreeOfLife.new(method: :tol_mrca)
 #      expect(a.uri.to_s).to eq('https://devapi.opentreeoflife.org/v2/tree_of_life/mrca')
 #    end
 #  end

 #  context 'basic use, for :about, in a response' do
 #    specify 'works' do
 #      a = Bark::Request::TreeOfLife.new(method: :tol_about, params: {})
 #      b = Bark::Response.new(request: a)
 #      expect(b.request_succeeded?).to be(true)
 #      expect(b.json.keys.include?('root_node_id')).to be(true)
 #    end
 #  end

    context 'shared tests' do
      run_tests(Bark::Request::GraphOfLife, SharedTestsHelper::SHARED_TESTS['graph_of_life'])
    end

 # end
end 
