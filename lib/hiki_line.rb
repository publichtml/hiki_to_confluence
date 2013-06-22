class HikiLine
  def initialize(text)
    @text = text
  end

  def convert
    text = @text
    text = convert_headings(text)
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
end