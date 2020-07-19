require "./spec_helper"
require "uuid"

describe "Base62" do
  it "UInt128 can be read as UUID" do
    (UInt128::MIN).unsafe_as(UUID).unsafe_as(UInt128).should eq UInt128::MIN
    (UInt128::MAX).unsafe_as(UUID).unsafe_as(UInt128).should eq UInt128::MAX
    (1_u128).unsafe_as(UUID).unsafe_as(UInt128).should eq 1_u128
    (256_u128).unsafe_as(UUID).unsafe_as(UInt128).should eq 256_u128
  end

  it "UUID can be read as UInt128" do
    (u = UUID.random).unsafe_as(UInt128).unsafe_as(UUID).should eq u
    (u = UUID.random).unsafe_as(UInt128).unsafe_as(UUID).should eq u
    (u = UUID.random).unsafe_as(UInt128).unsafe_as(UUID).should eq u
    (u = UUID.random).unsafe_as(UInt128).unsafe_as(UUID).should eq u

    (u = UUID.empty).unsafe_as(UInt128).unsafe_as(UUID).should eq u
  end

  it "UUID can be instanciated zero" do
    list = StaticArray(UInt8, 16).new(0)
    uuid1 = UUID.new list
    uuid2 = UUID.new uuid1.bytes
    uuid1.should eq uuid2
  end

  it "UUID can be instanciated random" do
    uuid1 = UUID.random
    uuid2 = UUID.new uuid1.bytes
    uuid1.should eq uuid2
  end

  it "merge_u8_to_u128" do
    # p Iom::Base62.str_to_uuid("20")
    # p Iom::Base62.str_to_uuid("200")
    # p Iom::Base62.str_to_uuid("2000")
    # p Iom::Base62.str_to_uuid("20000")
    # p Iom::Base62.str_to_uuid("200000")
    # p Iom::Base62.str_to_uuid("2000000")
    # p Iom::Base62.str_to_uuid("20000000")
    # p Iom::Base62.str_to_uuid("200000000")

    Iom::Base62.encode(i = UInt64::MAX).should eq s = "lYGhA16ahyf"
    Iom::Base62.decode(s).should eq i

    Iom::Base62.encode(i = UInt128::MAX).should eq s = "7N42dgm5tFLK9N8MT7fHC7"
    Iom::Base62.decode(s).should eq i
  end

  it "0..256 comes out correctly and is reversible" do
    (0_u16..256_u16).each do |int|
      str = Iom::Base62.encode(int)
      Iom::Base62.decode(str).should eq int
      Iom::Base62.decode("0#{str}").should eq int
    end
  end

  it "reversible for large valid values" do
    Iom::Base62.encode(i = 27220768_u128).should eq (s = "1QdmE")
    Iom::Base62.decode(s).should eq i

    Iom::Base62.encode(i = 123456789_u128).should eq (s = "8m0Kx")
    Iom::Base62.decode(s).should eq i

    Iom::Base62.encode(i = 1234567890_u128).should eq (s = "1ly7vk")
    Iom::Base62.decode(s).should eq i

    # largest value that works with the current algorithm: 2,748,398,495
    Iom::Base62.encode(i = 2748398495_u128).should eq (s = "2ZZZZZ")
    Iom::Base62.decode(s).should eq i

    u1 = UUID.random
    # pp id.bytes.map{ |b| (b = Iom::Base62.encode(b.to_u128)).size == 2 ? b : "0b" }
    v = u1.to_base62
    u2 = UUID.from_base62(v).not_nil!
    u2.should eq u1
  end

  it "UUID can be exported directly to base62 and back" do
    UUID.from_base62((u = UUID.random).to_base62).should eq u
    UUID.from_base62((u = UUID.random).to_base62).should eq u
    UUID.from_base62((u = UUID.random).to_base62).should eq u
    UUID.from_base62((u = UUID.random).to_base62).should eq u
  end
end
