require_relative '../../test_helper'

describe DMAPParser::Builder do
  before do
    @pair_data = DMAPParser::Builder.cmpa do
      cmpg '4E0573EF9BB80682'
      cmnm 'Name'
      cmty 'iPod'
    end
  end

  it 'should return a valid string' do
    dmap = @pair_data.to_dmap
    dmap.must_be_instance_of String
    DMAPParser::Parser.parse(dmap).to_dmap.must_equal(dmap)
  end

  it 'should raise an exception if tags are put inside non-containers' do
    lambda do
      DMAPParser::Builder.cmnm do
        cmpg '4E0573EF9BB80682'
        cmty 'iPod'
      end
    end.must_raise RuntimeError
  end

  it 'should return a TagContainer' do
    @pair_data.must_be_instance_of DMAPParser::TagContainer
  end

  it 'should store the correct values' do
    @pair_data.cmpg.must_equal '4E0573EF9BB80682'
    @pair_data.cmnm.must_equal 'Name'
    @pair_data.cmty.must_equal 'iPod'
  end

  it 'should store the correct Tags' do
    @pair_data.get_tag(:cmpg).must_be_instance_of DMAPParser::Tag
    @pair_data.get_tag(:cmnm).must_be_instance_of DMAPParser::Tag
    @pair_data.get_tag(:cmty).must_be_instance_of DMAPParser::Tag
  end

  it 'should fail if there is no container' do
    -> { DMAPParser::Builder.cmnm }.must_raise RuntimeError
  end

  it 'should support deep nesting' do
    nested = DMAPParser::Builder.mcon do
      miid 0
      mcon do
        miid 1
        mcon do
          miid 2
          mcon do
            miid 3
          end
        end
      end
    end

    nested.must_be_instance_of DMAPParser::TagContainer
    mcon = nested
    3.times do |i|
      mcon.miid.must_equal i
      mcon = mcon.mcon
    end
    dmap = nested.to_dmap
    DMAPParser::Parser.parse(dmap).to_dmap.must_equal(dmap)
  end

  it 'should correctly encode hexadecimal strings' do
    dmap = DMAPParser::Builder.cmpa do
      cmpg '4E0573EF9BB80682'
    end.to_dmap
    byte_string = [78, 5, 115, 239, 155, 184, 6, 130]
    dmap.bytes[-8..-1].must_equal(byte_string)
    dmap_reparsed = DMAPParser::Parser.parse(dmap).to_dmap
    dmap_reparsed.bytes[-8..-1].must_equal(byte_string)
  end

  it 'should output binary strings' do
    @pair_data.to_dmap.encoding.must_equal(Encoding::BINARY)
  end
end
