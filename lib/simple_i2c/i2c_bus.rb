
module SimpleI2c

  class I2CBus
    I2C_SLAVE = 0x0703
    I2C_SLAVE_FORCE = 0x0706

    def initialize(path: nil, force: false)
      @path =  Integer === path ? "/dev/i2c-#{path}" : (path || Dir.glob("/dev/i2c-*").sort.last)
      raise ArgumentError, "#{@path} is required" unless File.exist?(@path)
      @slave_command = force ? I2C_SLAVE_FORCE : I2C_SLAVE
    end

    def self.[](bus) = new(path: bus)

    def [](address)
      SimpleI2c::I2CDevice.new(self, address)
    end

    def access(address)
      File.open(@path, "w+") do |i2c|
        i2c.ioctl(@slave_command, address)
        yield i2c
      end
    end

  end

end