module Validations

#----自分の駒を選んでいるかどうか確認------------------------------------------------
  def validate_1
    r = method(:red_color)
    finish
    #先手が後手の駒を選ぶとエラー
    if @fs == 1 && @b[@before_p].include?("#")
      puts r.call(@error_2)
      @before_p = gets.to_i; validate_1
    #後手が先手の駒を選ぶとエラー
    elsif @fs == 2 && @b[@before_p] =~ /^\p{Han}|^\p{Hiragana}/
      puts r.call(@error_2)
      @before_p = gets.to_i; validate_1
    #何もないマスを選ぶとエラー
    elsif @b[@before_p] == "\s\s\s"
      puts r.call(@error_2)
      @before_p = gets.to_i; validate_1
    else
    end
  end
#-------------------------------------------------------------------------------

#----その駒が動ける範囲の場所を指定しているかどうか（その駒の動きに合っているかどうか）------
  def validate_2
    @gap = @before_p - @after_p
    @kyo = [*(1..8)].reverse
    @kei = [-8,12]
    @gin = [1,-9,9,-11,11]
    @kin = [-1,1,-9,-10,10,11]
    @ou  = [-1,1,-9,9,-10,10,-11,11]
    @kaku  = [9, 11, 18, 22, 27, 33, 36, 44, 45, 54, 55, 63, 66, 72, 77, 81, 88]
    @hisha = [1, 2, 3, 4, 5, 6, 7, 8, 10, 20, 30, 40, 50, 60, 70, 80]
    @bnum_1  = @before_p.to_s.chars[1].to_i
    @bnum_10 = @before_p.to_s.chars[0].to_i
    @anum_1  = @after_p.to_s.chars[1].to_i
    @anum_10 = @after_p.to_s.chars[0].to_i
    case @b[@before_p]
    when /歩/
      corners
      validate_error unless @gap == 1
    when /香/
      corners
      validate_error unless @kyo.drop(9 - @bnum_1).include?(@gap)
    when /桂/
      particular
      validate_error unless @kei.include?(@gap)
    when /銀/
      validate_error unless @gin.include?(@gap)
    when /金|と|よ|け|ぎ/
      validate_error unless @kin.include?(@gap)
    when /王|玉/
      validate_error unless @ou.include?(@gap)
    when /角/
      validate_error unless @kaku.include?(@gap.abs)
    when /飛/
      validate_error unless @hisha.include?(@gap.abs)
    when /馬/
      validate_error unless @kaku.concat(@ou).include?(@gap.abs)
    when /龍/
      validate_error unless @hisha.concat(@ou).include?(@gap.abs)
    else
    end
    validate_3
    validate_4
  end

  def validate_error
    r = method(:red_color)
    c = caller
    case c.first
    when /validate_2|validate_3/; puts @space_3 * 2 + r.call(@error_5)
    when /validate_4/; puts @space_3 * 2 + r.call(@error_6)
    end
    @after_p = gets.to_i
    phase_6
  end
#-------------------------------------------------------------------------------

#----歩、香車、桂馬に限り、強制的に成り駒になるパターン---------------------------------
  def corners
    #歩、香車が端まできたら強制的に成るロジック
    case @before_p.to_s
    when /2$/; turn_army
    end
  end

  def particular
    case @before_p.to_s
    when /3$|4$/; turn_army
    end
  end
#-------------------------------------------------------------------------------

#----選んだ駒が動ける位置かどうかの確認----------------------------------------------
  def validate_3
    #香車、角、飛車、距離が一以上の駒の動きの確認。間に駒があればそこまでしか動けない。
    @leftovers = []
    distance  = (@after_p + 1)..(@before_p - 1)
    rdistance = (@before_p + 1)..(@after_p - 1)
    case @b[@before_p]
    when /香/
      if @b[distance].join =~ /\p{Han}|\p{Hiragana}/
        validate_error
      end
      oute if @b[@after_p] =~ /王/ && @fs == 1
      oute if @b[@after_p] =~ /玉/ && @fs == 2
    when /角|馬/
    when /飛|龍/
      if    0 < @gap && @anum_10 == @bnum_10 &&
            @b[distance].join =~ /\p{Han}|\p{Hiragana}/
            validate_error
      elsif @gap < 0 && @anum_10 == @bnum_10 &&
            @b[rdistance].join =~ /\p{Han}|\p{Hiragana}/
            validate_error
      # elsif 0 < @gap && @anum_1 == @bnum_1 &&
      #
      # elsif @gap < 0 && @anum_1 == @bnum_1 &&
      end
    end
  end
#-------------------------------------------------------------------------------

#----選んだ位置が自分の駒だとエラー--------------------------------------------------
  def validate_4
    case @fs
    when 1; validate_error if @b[@after_p] =~ /^\p{Han}|^\p{Hiragana}/
    when 2; validate_error if @b[@after_p].include?("#")
    end
  end
#-------------------------------------------------------------------------------

#----先手、後手で処理を分ける（周りの駒の確認）----------------------------------------
  def check_2(string, num)
    color = method(:red_color)
    case @fs
    when 1
      if string.count("\s\s\s") == 0 &&
        string.join.chars.count("#") == 0
        puts color.call(@error_3)
        @before_p = gets.to_i; phase_3
      end
    when 2
      if string.join.chars.count("#") == num
        puts color.call(@error_3)
        @before_p = gets.to_i; phase_3
      end
    end
  end
#-------------------------------------------------------------------------------

#----選んだ駒が何かの判別、選んだ駒が動ける場所があるか---------------------------------
  def check_1
    finish
    case @b[@before_p]
    when /歩|香/;  ahead; check_2(@ahead, 1)
    when /桂/; jump_2; check_2(@jump_2, 2)
    when /銀/;  ahead;     x; check_2(@ahead | @x, 5)
    when /金|と|よ|け|ぎ/; gold_2; cross; check_2(@gold_2 | @cross, 6)
    when /王|玉/;      x; cross; check_2(@x | @cross, 8)
    when /角/;      x; check_2(@x, 4)
    when /飛/;  cross; check_2(@cross, 4)
    when /馬/;      x; cross; check_2(@x | @cross, 8)
    when /龍/;      x; cross; check_2(@x | @cross, 8)
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
