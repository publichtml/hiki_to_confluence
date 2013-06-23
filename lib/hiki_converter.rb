class HikiConverter
  def initialize(text)
    raw_lines = text.split(/\n/)
    @lines = raw_lines.map{ |line| HikiLine.new(line) }
  end

  def convert
    converted_texts = []
    @lines.each_with_index do |line, cnt|
      converted_texts << line.convert
    end

    converted_texts.join("\n") + "\n"
  end
end