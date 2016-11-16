require_relative '../../test_helper'

describe DMAPParser::Tag do
  it 'should return the correct value' do
    subject = DMAPParser::Tag.new(:minm, 'Test thing')
    subject.value.must_equal 'Test thing'
    subject.type.must_equal DMAPParser::TagDefinition[:minm]
  end

  it 'should be recognizable as a tag' do
    subject = DMAPParser::Tag.new(:minm, 'Test thing')
    subject.to_s.must_equal('#<DMAPParser::Tag minm (dmap.itemname: string)>')
  end
end
