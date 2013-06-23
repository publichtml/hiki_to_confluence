require "spec_helper"

describe HikiLine do
  describe "#covert" do
    subject{ HikiLine.new(@text) }

    context "convert headings" do
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

    context "convert links" do
      it "'[[*]]' => '[*]'" do
        @text = "[[link|http://example.com]]"
        expect(subject.convert).to eq "[link|http://example.com]"
      end
    end

    context "unordered lists" do
      it "'*' => '* '" do
        @text = "*list level 1"
        expect(subject.convert).to eq "* list level 1"
      end

      it "'**' => '** '" do
        @text = "**list level 2"
        expect(subject.convert).to eq "** list level 2"
      end

      it "'***' => '*** '" do
        @text = "***list level 3"
        expect(subject.convert).to eq "*** list level 3"
      end

      it "'****' => '**** '" do
        @text = "****list level 4"
        expect(subject.convert).to eq "**** list level 4"
      end
    end

    context "ordered lists" do
      it "'#' => '# '" do
        @text = "#list level 1"
        expect(subject.convert).to eq "# list level 1"
      end

      it "'##' => '## '" do
        @text = "##list level 2"
        expect(subject.convert).to eq "## list level 2"
      end

      it "'###' => '#### '" do
        @text = "###list level 3"
        expect(subject.convert).to eq "### list level 3"
      end

      it "'####' => '#### '" do
        @text = "####list level 4"
        expect(subject.convert).to eq "#### list level 4"
      end
    end

    context "bold text" do
      it "\"'''\" => \"*\"" do
        @text = "This is '''bold''' t'''ex'''t."
        expect(subject.convert).to eq "This is *bold* t*ex*t."
      end
    end

    context "line breaks" do
      it "'{{br}}' => '\\'" do
        @text = "The quick brown{{br}} fox jump{{br}}s over the lazy dog."
        expect(subject.convert).to eq "The quick brown\\ fox jump\\s over the lazy dog."
      end
    end
  end
end
