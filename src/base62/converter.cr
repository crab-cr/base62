module Iom::Base62
  struct Converter
    property charset : String
    property base : UInt128

    def initialize(@charset : String)
      @base = @charset.size.to_u128
    end

    def encode(value : Int) : String
      return @charset[0].to_s if value == 0_u8

      res = ""
      while value > 0_u8
        r = value % @base
        res = @charset[r] + res
        # floor division: //
        value = (value // @base)
      end
      res
    end

    def decode(str : String) : UInt128
      str = str.lstrip "0"
      res : UInt128 = 0_u128
      len = str.size
      char = 0_u128

      str.each_char_with_index do |char, index|
        unless (value = (@charset.index char)).nil?
          res += value.to_u128 * (@base ** (len - index - 1))
        end
      end
      res
    end

    def self.uuid_to_base62(uuid : UUID) : String
      encode(uuid.unsafe_as(UInt128))
    end

    def self.uuid_from_base62(input : String) : UUID?
      decode(input).unsafe_as(UUID)
    end
  end
end
