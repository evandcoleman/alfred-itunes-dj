require_relative '../../test_helper'

describe DMAPParser::Parser do
  it 'should raise a ParserError when given invalid data' do
    invalid = []
    20.times do
      invalid << (0..255).map(&:chr).join # random data
    end
    invalid << "rand\x00\x00\x00\x01" # non correct size
    invalid << "mcon\x00\x00\x00\x05rand\x09" # wrong tag size
    invalid << "msup\x00\x00\x00\x01\x01" # not a container!
    invalid << "rand\x00\x00\x00\x01\x01" # not a container!
    invalid.each do |data|
      lambda do
        DMAPParser::Parser.parse(data)
      end.must_raise(DMAPParser::Parser::ParseError)
    end
  end

  it 'should return nil if the string is empty' do
    -> { DMAPParser::Parser.parse('') }.must_raise DMAPParser::Parser::ParseError
  end

  it 'should ignore padding' do
    dmap = support_file('simple.dmap').read
    dmap.force_encoding(Encoding::BINARY)
    padded = DMAPParser::Parser.parse(dmap + 'I AM PADDING!!11!!')
    padded.to_dmap.must_equal dmap
  end

  it 'should parse an empty container' do
    data = "mcon\x00\x00\x00\x00"
    mcon = DMAPParser::Parser.parse(data)
    mcon.must_be_instance_of DMAPParser::TagContainer
    mcon.to_a.must_be_empty
  end

  it 'should accept IO objects' do
    data = DMAPParser::Parser.parse(support_file('simple.dmap'))
    data.mstt.must_equal 200
  end

  it 'should parse iTunes content-types' do
    data = DMAPParser::Parser.parse(support_file('content_codes.dmap'))
    data.type.tag.must_equal 'mccr'
    data.mstt.must_equal 200
    data.to_a.count.must_equal 184
  end

  it 'should parse unknown tags' do
    data = "mcon\x00\x00\x00\x15xkcd\x00\x00\x00\x0dis a webcomic"
    data = DMAPParser::Parser.parse(data)
    data.xkcd?.must_equal true
  end

  it 'should guess the type of unknown tags' do
    data = "mcon\x00\x00\x00\x15xkcd\x00\x00\x00\x0Dis a webcomic"
    data = DMAPParser::Parser.parse(data)
    data.xkcd.must_equal 'is a webcomic'
    data = "mcon\x00\x00\x00\x0Ajurp\x00\x00\x00\x02\x13\x37"
    data = DMAPParser::Parser.parse(data)
    data.jurp.must_equal 0x1337
  end

  it 'should parse strings as UTF-8' do
    dmap = DMAPParser::Builder.cmpa do
      cmnm '4E0573EF9BB80682'
    end.to_dmap
    DMAPParser::Parser.parse(dmap).cmnm.encoding.must_equal(Encoding::UTF_8)
  end
end
