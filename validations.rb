module Validations

#----自分の駒を選んでいるかどうか確認------------------------------------------------
  def validate_1
    color = method(:red_color)
    finish
    #先手が後手の駒を選ぶとエラー
    if @fs == 1 && @b[@before_p].include?("#")
      puts color.call(@error_2)
      @before_p = gets.to_i; validate_1
    #後手が先手の駒を選ぶとエラー
    elsif @fs == 2 && @b[@before_p] =~ /^\p{Han}|^\p{Hiragana}/
      puts color.call(@error_2)
      @before_p = gets.to_i; validate_1
    #何もないマスを選ぶとエラー
    elsif @b[@before_p] == "\s\s\s"
      puts color.call(@error_2)
      @before_p = gets.to_i; validate_1
    else
    end
  end
#-------------------------------------------------------------------------------

#----その駒が動ける範囲の場所を指定しているかどうかの判別-------------------------------
  def validate_2
  end
#-------------------------------------------------------------------------------

#----選んだ駒が動ける位置かどうかの確認（その駒の動きに合っているかどうか）-----------------
  def validate_3

  end
#-------------------------------------------------------------------------------

#----先手、後手で処理を分ける（周りの駒の確認）----------------------------------------
  def check_1_1(string, num)
    color = method(:red_color)
    case @fs
    when 1
      if string.count("\s\s\s") == 0 &&
        string.join.chars.count("#") == 0
        puts color.call(@error_3)
        @before_p = gets.to_i; check_1
      end
    when 2
      if string.join.chars.count("#") == num
        puts color.call(@error_3)
        @before_p = gets.to_i; check_1
      end
    end
  end
#-------------------------------------------------------------------------------

#----選んだ駒が何かの判別、選んだ駒が動ける場所があるか---------------------------------
  def check_1
    finish
    case @b[@before_p]
    when /歩/;  ahead; check_1_1(@ahead, 1)
    when /香/;  ahead; check_1_1(@ahead, 1)
    when /桂/; jump_2; check_1_1(@jump_2, 2)
    when /銀/;  ahead; cross; check_1_1(@ahead | @cross, 5)
    when /金/; gold_2; cross; check_1_1(@gold_2 | @cross, 6)
    when /王/;      x; cross; check_1_1(@x | @cross, 8)
    when /玉/;      x; cross; check_1_1(@x | @cross, 8)
    when /角/;      x; check_1_1(@x, 4)
    when /飛/;  cross; check_1_1(@cross, 4)
    #成駒
    when /と/; gold_2; cross; check_1_1(@gold_2 | @cross, 6)
    when /よ/; gold_2; cross; check_1_1(@gold_2 | @cross, 6)
    when /け/; gold_2; cross; check_1_1(@gold_2 | @cross, 6)
    when /ぎ/; gold_2; cross; check_1_1(@gold_2 | @cross, 6)
    when /馬/;      x; cross; check_1_1(@x | @cross, 8)
    when /龍/;      x; cross; check_1_1(@x | @cross, 8)
    else
    end
  end
#-------------------------------------------------------------------------------

#----@before_pの場所の四方八方に駒があるかどうか、それが何かの判別----------------------
#----前方に駒があるかどうか--------------------------------------------------------
  def ahead
    @ahead.clear
    @ahead << @b[@before_p - 1] #前方
  end
#-------------------------------------------------------------------------------

#----斜め４箇所に駒があるかどうか---------------------------------------------------
  def x
    @x.clear
    @x << @b[@before_p - 11] #右上
    @x << @b[@before_p + 11] #左上
    @x << @b[@before_p - 9] #右下
    @x << @b[@before_p + 9] #左下
  end
#-------------------------------------------------------------------------------

#----十字方向に駒があるかどうか-----------------------------------------------------
  def cross
    @cross.clear
    @cross << @b[@before_p - 10] #右
    @cross << @b[@before_p + 10] #左
    @cross << @b[@before_p - 1] #上
    @cross << @b[@before_p + 1] #下
  end
#-------------------------------------------------------------------------------

#----前方斜めに箇所に駒があるかどうか（主に金と成金よう）-------------------------------
  def gold_2
    @gold_2.clear
    @gold_2 << @b[@before_p - 11] #右上
    @gold_2 << @b[@before_p + 9] #左上
  end
#-------------------------------------------------------------------------------

#----前方一つ飛ばしで斜め２箇所に駒があるかどうか--------------------------------------
  def jump_2
    @jump_2.clear
    @jump_2 << @b[@before_p - 12] #一つ右上
    @jump_2 << @b[@before_p + 8] #一つ左上
  end
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

end
