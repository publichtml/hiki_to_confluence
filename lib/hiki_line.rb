class HikiLine
  def initialize(text)
    @text = text
  end

  def convert
    text = @text
    text = convert_headings(text)
    text = convert_links(text)
    text = convert_lists(text)
    text = convert_bold_texts(text)
    text = convert_line_breaks(text)
    text = convert_tables(text)
  end

  def indented?
    !!(@text =~ /^ /)
  end

  def blank?
    @text.rstrip.blank?
  end

  def present?
    !blank?(@text)
  end

  def include_quote_markup?
    indented? || !!(@text =~ /^(<<<|>>>)\s*$/)
  end

  private

  def convert_headings(text)
    converted = text
    converted.gsub!("!!!!!!", "h6. ")
    converted.gsub!("!!!!!",  "h5. ")
    converted.gsub!("!!!!",   "h4. ")
    converted.gsub!("!!!",    "h3. ")
    converted.gsub!("!!",     "h2. ")
    converted.gsub!("!",      "h1. ")
    converted
  end

  def convert_links(text)
    converted = text
    converted.gsub!("[[", "[")
    converted.gsub!("]]", "]")
    converted
  end

  def convert_lists(text)
    converted = text
    converted.gsub!(/\*([^\*\s])/){ "* #{$1}"}
    converted.gsub!(/\#([^\#\s])/){ "# #{$1}"}
    converted
  end

  def convert_bold_texts(text)
    text.gsub("'''", "*")
  end

  def convert_line_breaks(text)
    text.gsub("{{br}}", "\\")
  end

  def convert_tables(text)
    text.gsub("||", "|")
  end
end
