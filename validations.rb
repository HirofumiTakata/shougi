module Validations

  def validate_1
    if @fs == 1 && @b[@first_p].include?("^")
      puts @error_2
    elsif @fs == 2 && @b[@first_p] =~ /^\p{Han}|^\p{Hiragana}/
      puts @error_2
    elsif @b[@first_p] == "\s\s\s"
      puts @error_2
    else
    end
  end

end
