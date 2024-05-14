# frozen_string_literal: false

require "test_helper"
require "simple_i2c"
require 'stringio'

class TestSimpleI2c < Minitest::Test
  def setup 
  end

  def test_that_it_has_a_version_number
    refute_nil ::SimpleI2c::VERSION
  end

  def test_that_names_are_accessible
    refute_nil ::SimpleI2c::I2CBus
    refute_nil ::SimpleI2c::I2CDevice
  end

  def test_creation_succeeds_with_a_bus_number
    File.stub :exist?, true do 
      assert ::SimpleI2c::I2CBus === ::SimpleI2c::I2CBus[1]
    end
  end

  def test_creation_succeeds_with_a_device_path
    File.stub :exist?, true do 
      assert ::SimpleI2c::I2CBus === ::SimpleI2c::I2CBus["/dev/i2c-1"]
    end
  end

  def test_that_creation_fails_with_a_bad_device_path
    File.stub :exist?, false do 
      assert_raises { ::SimpleI2c::I2CBus === ::SimpleI2c::I2CBus["/dev/i2c-1"] }
    end
  end

  def test_that_it_finds_a_bus
    File.stub :exist?, true do 
      assert ::SimpleI2c::I2CBus === ::SimpleI2c::I2CBus[1]
    end
  end
end

class TestSimpleI2cDevice < Minitest::Test

  def setup
    @fake_file_path = '/tmp/fake_i2c'
    File.write(@fake_file_path, "")
    @bus = ::SimpleI2c::I2CBus[@fake_file_path]
    @dev = @bus[0x3f]
  end

  def test_that_it_tests
    assert ::SimpleI2c::I2CDevice === @bus[0x1]
  end

  def test_that_it_reads
    m = Minitest::Mock.new
    m.expect :syswrite, true, [0x02.chr]
    m.expect :sysread, 'abc', [3]


    @bus.stub :access, 0x01, m do
      d = @bus[0x01]
      d[0x02,3]
    end

    m.verify
  end

  def test_that_it_writes_strings
    m = Minitest::Mock.new
    m.expect :syswrite, true, ["\x02abc"]
    @bus.stub(:access, 0x01,  m) { @dev[0x02] = "abc" }
    m.verify
  end

  def test_that_it_writes_arrays
    v = @dev.int_to_buffer(0x0102030405).pack("C*")
    m = Minitest::Mock.new
    m.expect :syswrite, true, ["\x02"+v]
    @bus.stub(:access, 0x01,  m) { @dev[0x02] = v.bytes }
    m.verify
  end

  def test_that_it_writes_integers
    v = @dev.int_to_buffer(0x0102030405).pack("C*")
    m = Minitest::Mock.new
    m.expect :syswrite, true, ["\x02"+v]
    @bus.stub(:access, 0x01,  m) { @dev[0x02] = 0x0102030405 }
    m.verify
  end
  
end



# if $0 == __FILE__

#   pp I2CBus[1][0x40][0x5,3].unpack("c3")
#   pp I2CBus[1][0x40][0x3e,2]

#   bus = I2CBus[1]
#   board = bus[0x40]
#   pp board[0x3e,2]

#   begin
#     I2CBus["/dev/unheardof"] 
#   rescue => e
#     puts e
#   end
  

# end

