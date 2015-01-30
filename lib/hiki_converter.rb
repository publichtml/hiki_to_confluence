class HikiConverter
  CONFLUENCE_QUOTE_MARKUP = "{code}"

  def initialize(text)
    raw_lines = text.split(/\n/)
    @lines = raw_lines.map{ |line| HikiLine.new(line) }
  end

  def convert
    converted_texts = []
    @lines.each_with_index do |line, cnt|
      if line.include_quote_markup?
        converted_texts << CONFLUENCE_QUOTE_MARKUP
      else
        converted_texts << line.convert
      end        
    end

    converted_texts.join("\n") + "\n"
  end
end