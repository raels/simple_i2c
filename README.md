# SimpleI2c

SimpleI2C provides simple Ruby classes to perform I2C operations on linux systems resembling Raspbian / Raspberry OS.

The library is small and simple. For example, this program reads 2 bytes from register 0x3f of device 0x40 on bus 1 (which is device file "/dev/i2c-1"):

```ruby

require 'simple_i2c'
require 'pp'

include SimpleI2c

# Compact form
pp SimpleI2C[1][0x40][0x37,2]

# Flexible form
bus = SimpleI2C[1]
device = bus[0x40]
device[0x37,2]

```

Likewise, we can also assign data. Let's set register 0xf0 to be the bytes [0x01, 0x02, 0x03]

```ruby

device = SimpleI2C[1][0x40]
device[0xf0] = [0x01, 0x02, 0x03]

```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add simplei2c

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install simplei2c

## Usor diligenter

The library is pure Ruby, but depends on the linux drivers for I2C being present, installed, and working. You need to know the bus numbers and device addresses for your I2C devices, as there is no automatic detection available. This library is not meant for high-speed operation; look to C++ implementations for that.

## Usage

The code above is pretty much the extent of the API. Create a bus object using new(bus_identifier), which is also available as I2CBus[bus_identifier]. This can be either an integer bus number (usually 1 on the RPi), or a path name ("/dev/i2c-1"). If you don't specify one, then it will choose /dev/i2c-0 as a default.

Once you have a bus, you can then create a device on that bus using new(bus_object, i2c_address), or I2CDevice[bus_object, i2c_address]. The object returned can then access the registers by accessing the device as if it were an array. For instance, dev[0x37,2] block-reads two bytes from register 0x37. Note that you can put in any number of bytes -- it is up to you to not mess up your device by not reading properly.

Setting register values is done in almost the same way: eg., dev[0x22] = [12,14] will send the two bytes 12 (0x0c) and 14 (0x0e) as a block write to the given register. You need to make sure your data is in the right format and byte order. The defaults are set for the Raspberry Pi and are tested there. The value you specify can be one of (1) a string (2) an array of integers, or (3) an integer; each will be converted into an array of 8-bit unsigned bytes, using the lower 8 bits of each value. Use which ever you prefer.

Note that the assignment function does a block-write to the device, prefixing the register number to the byte array being sent. If you want some other behavior, this is not the library for you.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/raels/simple_i2c. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/raels/simple_i2c/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleI2c project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple_i2c/blob/master/CODE_OF_CONDUCT.md).
