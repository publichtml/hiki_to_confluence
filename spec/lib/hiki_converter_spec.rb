require "spec_helper"

describe HikiConverter do
  describe "#covert" do
    subject{ HikiConverter.new(@text) }

    context "converts" do
      it "headings, links, lists, bold texts, line breaks, tables" do
        @text = <<EOS
!headings1
[[link|http://example.com]]
!!headings2
*[[link2|http://example.com/link2]]
**level2
*** level3
****level4
!!!headings3
#level1

##level2-1
##level2-2
### level3
#### level4
!!!!headings4
aaa'''bbb'''{{br}}cccc
!!!!!headings5
||td1|| td2 || td3{{br}}aaa||
!!!!!!headings6
EOS

        expect(subject.convert).to eq <<EOS
h1. headings1
[link|http://example.com]
h2. headings2
* [link2|http://example.com/link2]
** level2
*** level3
**** level4
h3. headings3
# level1

## level2-1
## level2-2
### level3
#### level4
h4. headings4
aaa*bbb*\\cccc
h5. headings5
|td1| td2 | td3\\aaa|
h6. headings6
EOS
      end

      it "quotes by '<<<' and '>>>' without nesting" do
        @text = <<EOS
<<<
quoted line1
quoted line2
>>>
EOS

        expect(subject.convert).to eq <<EOS
{code}
quoted line1
quoted line2
{code}
EOS
      end

      it "quotes by ' ' without nesting" do
        pending("This will be cared after HikiLine#sprit_quote_markups")
        @text = <<EOS
 quoted line1
  quoted line2
>>>
EOS

        expect(subject.convert).to eq <<EOS
{code}
quoted line1
 quoted line2
{code}
EOS
      end
    end
  end
end