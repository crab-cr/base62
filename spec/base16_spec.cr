require "./spec_helper"
require "uuid"

describe "Base16" do
  # crystal probably has a superior built-in for base16,
  # but we want to be sure custom bases function correctly
  it "Base16 works as expected" do
    bc = Iom::Base62::Converter.new("0123456789abcdef")
    bc.base.should eq 16
    bc.decode("1337").should eq 4919_u128
    bc.encode(4919_u128).should eq "1337"
    bc.encode(1337_u128).should eq "539"
    bc.decode("fff").should eq 4095_u128
  end

  it "0..256 comes out correctly and is reversible" do
    bc = Iom::Base62::Converter.new("0123456789abcdef")
    (0_u16..256_u16).each do |int|
      str = Iom::Base62.encode(int)
      Iom::Base62.decode(str).should eq int
      Iom::Base62.decode("0#{str}").should eq int
    end
  end
end
