require "spec_helper"

describe HikiLine do
  describe "#covert" do
    context "convert headings" do
      subject{ HikiLine.new(@text) }

      it "'!' => 'h1. '" do
        @text = "!heading1 title"
        expect(subject.convert).to eq "h1. heading1 title"
      end

      it "'!!' => 'h2. '" do
        @text = "!!heading2 title"
        expect(subject.convert).to eq "h2. heading2 title"
      end

      it "'!!' => 'h3. '" do
        @text = "!!!heading3 title"
        expect(subject.convert).to eq "h3. heading3 title"
      end

      it "'!!' => 'h4. '" do
        @text = "!!!!heading4 title"
        expect(subject.convert).to eq "h4. heading4 title"
      end

      it "'!!' => 'h5. '" do
        @text = "!!!!!heading5 title"
        expect(subject.convert).to eq "h5. heading5 title"
      end

      it "'!!' => 'h6. '" do
        @text = "!!!!!!heading6 title"
        expect(subject.convert).to eq "h6. heading6 title"
      end
    end
  end
end