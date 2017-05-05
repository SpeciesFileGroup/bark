require 'spec_helper'

describe Bark do

  # TODO: Check that shared tests were built correctly, and warn if not

  context '.request_class - determing request type from method' do
    specify 'for tol_' do
      expect(Bark.request_class('tol_about')).to eq(Bark::Request::TreeOfLife)
      expect(Bark.request_class(:tol_about)).to eq(Bark::Request::TreeOfLife)
    end

    specify 'for gol_' do
      expect(Bark.request_class('gol_about')).to eq(Bark::Request::GraphOfLife)
      expect(Bark.request_class(:gol_about)).to eq(Bark::Request::GraphOfLife)
    end
 
    specify 'for tnrs_' do
      expect(Bark.request_class('tnrs_match_names')).to eq(Bark::Request::Tnrs)
      expect(Bark.request_class(:tnrs_match_names)).to eq(Bark::Request::Tnrs)
    end

    specify 'for taxonomy_' do
      expect(Bark.request_class('taxonomy_about')).to eq(Bark::Request::Taxonomy)
      expect(Bark.request_class(:taxonomy_about)).to eq(Bark::Request::Taxonomy)
    end
 
    specify 'for studies_' do
      expect(Bark.request_class('studies_find_studies')).to eq(Bark::Request::Studies)
      expect(Bark.request_class(:studies_find_studies)).to eq(Bark::Request::Studies)
      expect(Bark.request_class('get_study')).to eq(Bark::Request::Studies)
      expect(Bark.request_class(:get_study)).to eq(Bark::Request::Studies)
    end

    specify 'for something_not_recognized' do
      expect(Bark.request_class(:something_not_recognized)).to eq(false)
      expect(Bark.request_class('something_not_recognized')).to eq(false)
    end
  end

  context 'convience wrapping methods' do
    context 'method_missing' do
      specify 'methods with indeterminable requests classes raise' do
        expect {Bark.foo}.to raise_error NoMethodError
      end

      specify 'methods with determinable request classes do not raise' do
        expect {Bark.get_study()}.to_not raise_error
      end

      specify 'methods with params do not raise' do
        expect { Bark.get_study(params: {'study_id' => 'px3454'})}.to_not raise_error 
      end

      specify 'a GET example returns' do
        expect( Bark.get_study(params: {:study_id => '2113'})['error']).to be_falsey
      end

    end
  end

  context 'shared tests' do
    specify 'are instantiated from a URL' do
      expect(SharedTestsHelper::SHARED_TESTS.count).to be > 0 
    end

    context 'SharedTestsHelper::OtTest' do
      let(:t) { SharedTestsHelper::OtTest.new  }

      specify 'have a name' do
        expect(t).to respond_to(:name)
      end

      specify 'reference a function' do
        expect(t).to respond_to(:method)
      end

      specify 'provide an input' do
        expect(t).to respond_to(:input)
      end

      specify 'expect multiple tests' do
        expect(t).to respond_to(:tests)
      end
    end
  end
end 
