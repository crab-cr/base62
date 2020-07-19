require "./base62/*"

module Iom::Base62
  VERSION = "0.1.0"

  @@base62 = Converter.new "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  @[AlwaysInline]
  def self.encode(v)
    @@base62.encode v
  end

  @[AlwaysInline]
  def self.decode(v)
    @@base62.decode v
  end

  @[AlwaysInline]
  def self.uuid_to_base62(uuid : UUID) : String
    encode(uuid.unsafe_as(UInt128))
  end

  @[AlwaysInline]
  def self.uuid_from_base62(input : String) : UUID?
    decode(input).unsafe_as(UUID)
  end
end
