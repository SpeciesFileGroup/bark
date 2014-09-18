require 'spec_helper'

# Meta-tests
describe SharedTestsHelper do

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
