
module SimpleI2c

  # I2CBuffer is a binary string - a string of bytes
  class I2CBuffer < Array

    def initialize *args, **kwargs, &block
      super
    end

    def self.from_s str
      raise ArgumentError unless String === str
      new(str.bytes)
    end

    def self.from_i value, nbytes = nil
      raise ArgumentError unless Integer === value
      return "\0" if value == 0
      return "" if value.nil?
      nbytes ||= ((value.bit_length-1) / 8) + 1
      arr = (nbytes-1).downto(0).map { value[8*_1,8] }
      new(arr)
    end

    def self.from_a arr
      new(arr.flatten)
    end
      
    def to_s fmt="C*"
      pack(fmt)
    end

    def to_i(shift_by=8)
      inject(0) { |acc, e| (acc << shift_by) | ((e & (1 << shift_by) - 1)) }
    end
  end
end

if $0 == __FILE__ 

include SimpleI2c

bufs = I2CBuffer.from_s("asdasdas")
bufi = I2CBuffer.from_i(0x0102030405)
bufa = I2CBuffer.from_a([1,2,3])
bufb = I2CBuffer[7,8,9]
buff1 = I2CBuffer.from_a([1,2,3,[4,[5,[6]]],7,8,9])
buff2 = I2CBuffer.from_a([1,2,3,[4,[5,[6]]],7,8,9].flatten)

b = [bufs, bufi, bufa, bufb, buff1, buff2].map { [_1, _1.to_s("n*"), _1.to_i] }

pp b
end
