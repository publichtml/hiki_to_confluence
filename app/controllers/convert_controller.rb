class ConvertController < ApplicationController
  def index
    return unless text = params[:text]

    # 本当はクラスとかhelperつくるべきなんだけど今回は面倒くさいからコントローラにベタ書き

    # 見出し
    text.gsub!("!!!!", "h4. ")
    text.gsub!("!!!", "h3. ")
    text.gsub!("!!", "h2. ")
    text.gsub!("!", "h1. ")

    # リンク
    text.gsub!("[[", "[")
    text.gsub!("]]", "]")

    # 太字
    text.gsub!("'''", "*")

    # 改行
    text.gsub!("{{br}}", "\\")

    # テーブル
    text.gsub!("||", "|")

    # >>> による引用
    text.gsub!("<<<", "{noformat}")
    text.gsub!(">>>", "{noformat}")

    # 行頭半角スペースによる引用
    lines = text.split(/\n/)
    prev_quoted = false
    index = 0
    converted_lines = lines.map do |line|
      if indented?(line)
        line = "{noformat}\n" + line unless prev_quoted
        prev_quoted = true
      elsif prev_quoted && blank?(line) && !next_present_line_indented?(index, lines)
        line = "{noformat}\n" + line
        prev_quoted = false
      end
      index += 1
      line
    end
    converted_lines << "\n{noformat}" if prev_quoted

    @converted = converted_lines.join
  end

  private

  def indented?(line)
    !!(line =~ /^ /)
  end

  def blank?(line)
    line.rstrip.blank?
  end

  def present?(line)
    !blank?(line)
  end

  def next_present_line_indented?(current_index, lines)
    return false unless line = next_present_line(current_index, lines)
    indented?(line)
  end

  def next_present_line(current_index, lines)
    lines[(current_index + 1)..lines.size].detect{ |line| present?(line) }
  end
end
