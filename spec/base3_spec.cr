require "./spec_helper"
require "uuid"

# an alternative character set that does not start with 012
private CHARS_LIST = "abc"

describe "Base3" do
  it "Base3 with UTF8 chars work as expected" do
    bc = Iom::Base62::Converter.new(CHARS_LIST)
    bc.base.should eq 3
    bc.decode("cba").should eq 21_u128
    bc.encode(4919_u128).should eq "cacacabc"
    bc.encode(1337_u128).should eq "bcbbbbc"
    bc.decode("bca").should eq 15_u128
  end

  it "0..256 comes out correctly and is reversible" do
    bc = Iom::Base62::Converter.new(CHARS_LIST)
    (0_u16..256_u16).each do |int|
      str = Iom::Base62.encode(int)
      Iom::Base62.decode(str).should eq int
      Iom::Base62.decode("0#{str}").should eq int
    end
  end
end
