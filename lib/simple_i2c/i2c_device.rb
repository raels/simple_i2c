require 'pry'

module SimpleI2c

  class I2CDevice 
    attr_accessor :bus, :address

    def initialize(bus,address)
      @bus = bus
      @address = address
    end

    def [](register,byte_count=1)
      bus.access(address) { |i2c| i2c.syswrite(register.chr) ; i2c.sysread(byte_count) }
    end
    

    def []=(register,data)
      v = [register, *param_to_buffer(data)].pack("C*")
      bus.access(address) do |i2c|
          i2c.syswrite(v) 
      end
    end

    def int_to_buffer(value, nbytes=nil)
      return "\0" if value == 0
      return "" if value.nil?
      nbytes ||= ((value.bit_length-1) / 8) + 1
      (nbytes-1).downto(0).map { value[8*_1,8] }
    end

    def buffer_to_int(value, shift_by = 8)
      value.bytes.inject(0) { |acc, e| (acc << shift_by) | ((e & (1 << shift_by) - 1)) }
    end

    def param_to_buffer(data)
      case data
      when String
        data.bytes
      when Integer
       int_to_buffer(data)
      when Array
       data.flatten
      end
    end

  end
end