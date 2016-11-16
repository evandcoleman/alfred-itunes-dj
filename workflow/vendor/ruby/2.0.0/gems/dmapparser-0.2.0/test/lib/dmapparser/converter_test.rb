require_relative '../../test_helper'

describe DMAPParser::Converter do
  it 'should return the original output again' do
    time = Time.now
    con = DMAPParser::Converter
    con.bin_to_date(con.date_to_bin(time)).to_i.must_equal time.to_i
    con.bin_to_bool(con.bool_to_bin(true)).must_equal true
    con.bin_to_int(con.int_to_bin(90_000)).must_equal 90_000
    con.bin_to_byte(con.byte_to_bin(190)).must_equal 190
    con.bin_to_long(con.long_to_bin(3**25)).must_equal 3**25
    con.bin_to_version(con.version_to_bin('932.200.3')).must_equal '932.200.3'
    con.bin_to_short(con.short_to_bin(19_007)).must_equal 19_007
  end

  it 'should automatically convert numerics' do
    con = DMAPParser::Converter
    byte = con.byte_to_bin(244)
    short = con.short_to_bin(244)
    int = con.int_to_bin(244)
    long =  con.long_to_bin(244)
    con.data_to_numeric(byte).must_equal(244)
    con.data_to_numeric(short).must_equal(244)
    con.data_to_numeric(int).must_equal(244)
    con.data_to_numeric(long).must_equal(244)
  end

  it 'should decode unknown types' do
    con = DMAPParser::Converter
    byte = con.byte_to_bin(244)
    con.decode(:ZZZZ, byte).must_equal 244
  end

  it 'should encode unknown strings' do
    con = DMAPParser::Converter
    con.encode(:ZZZZ, 'aaa').must_equal 'aaa'
  end
end
