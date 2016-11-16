require_relative '../../test_helper'

describe DMAPParser::TagContainer do
  it 'should respond to known tags' do
    subject = DMAPParser::TagContainer.new(:mcon,
                                           [DMAPParser::Tag.new(:minm, 1337)])
    subject.respond_to?(:unknown).must_equal false
    subject.respond_to?(:minm).must_equal true
    subject.minm.must_equal 1337
    subject.unknown.must_equal nil
    subject.inspect.must_include('minm')
    subject.inspect.must_include('1337')
  end
end
