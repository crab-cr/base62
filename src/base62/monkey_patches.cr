struct UUID
  @[AlwaysInline]
  def to_base62 : String
    Iom::Base62.uuid_to_base62(self)
  end

  @[AlwaysInline]
  def self.from_base62(input : String) : UUID?
    Iom::Base62.uuid_from_base62(input)
  end
end

struct UInt128
  @[AlwaysInline]
  def to_base62 : String
    Iom::Base62.encode(self)
  end

  @[AlwaysInline]
  def self.from_base62(input : String) : UInt128?
    Iom::Base62.decode(input)
  end
end

struct Int64
  @[AlwaysInline]
  def to_base62 : String
    Iom::Base62.encode(self.to_u128)
  end

  @[AlwaysInline]
  def self.from_base62(input : String) : Int64?
    Iom::Base62.decode(input).to_i64
  end
end
