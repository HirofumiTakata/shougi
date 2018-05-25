class ShougiApp
  require './validations'
  require './methods'
  require './variable'
  include Validations
  include Methods
  include Variable

#----初期画面（選択していく画面）---------------------------------------------------
  def start
    puts @space_3 + @box_line
    puts @space_3 + @message_1_1
    puts @space_3 + @message_1_2
    puts @space_3 + @box_line
    case gets.to_i
    when 1; selection
    when 2; exit
    else  ; selection
    end
  end

  def selection
    puts @space_3 + @box_line
    puts @space_3 + @message_2_1
    puts @space_3 + @message_2_2
    puts @space_3 + @message_2_3
    puts @space_3 + @box_line
    case gets.to_i
    when 1; hirate
    when 2; options
    when 3; start
    else  ; hirate
    end
  end

  def options
    puts @space_3 + @box_line
    puts @space_3 + @message_2_2_1
    puts @space_3 + @message_2_2_2
    puts @space_3 + @message_2_2_3
    puts @space_3 + @message_2_2_4
    puts @space_3 + @message_2_2_5
    puts @space_3 + @message_2_2_6
    puts @space_3 + @box_line
    case gets.to_i
    when 1; handicap_1
    when 2; handicap_2
    when 3; handicap_4
    when 4; handicap_6
    when 5; time_battle
    when 6; selection
    else  ; start
    end
  end

  def handicap_1
    puts @space_3 + @box_line
    puts @space_3 + @message_2_2_1_1
    puts @space_3 + @message_2_2_1_2
    puts @space_3 + @message_2_2_1_3
    puts @space_3 + @message_2_2_1_4
    puts @space_3 + @message_2_2_1_5
    puts @space_3 + @box_line
    case gets.to_i
    when 1; handicap_1_1f
    when 2; handicap_1_2f
    when 3; handicap_1_1h
    when 4; handicap_1_2h
    when 5; options
    else  ; start
    end
  end

  def handicap_2
    puts @space_3 + @box_line
    puts @space_3 + @message_2_2_2_1
    puts @space_3 + @message_2_2_2_2
    puts @space_3 + @message_2_2_2_3
    puts @space_3 + @box_line
    case gets.to_i
    when 1; handicap_2_1
    when 2; handicap_2_2
    when 3; options
    else  ; start
    end
  end

  def handicap_4
    puts @space_3 + @box_line
    puts @space_3 + @message_2_2_3_1
    puts @space_3 + @message_2_2_3_2
    puts @space_3 + @message_2_2_3_3
    puts @space_3 + @box_line
    case gets.to_i
    when 1; handicap_4_1
    when 2; handicap_4_2
    when 3; options
    else  ; start
    end
  end

  def handicap_6
    puts @space_3 + @box_line
    puts @space_3 + @message_2_2_4_1
    puts @space_3 + @message_2_2_4_2
    puts @space_3 + @message_2_2_4_3
    puts @space_3 + @box_line
    case gets.to_i
    when 1; handicap_6_1
    when 2; handicap_6_2
    when 3; options
    else  ; start
    end
  end

  def time_battle
    @time_bttle_switch = true
    game
  end

#-------------------------------------------------------------------------------

#----将棋の盤・駒の表示------------------------------------------------------------
  def game
    @count += 1
    @count.even? ? @fs = 1 : @fs = 2
    if @count == 0
      display_ban
    else
      @b = @b.reverse
      display_ban
    end
    phase_1
  end
#-------------------------------------------------------------------------------

#----次のステージ-----------------------------------------------------------------
  def phase_1
    regular_message
    timer if @time_battle_switch
    puts @fs
    puts @space_3 * 2 + @message_g_1
    puts @count
    @first_p = gets.to_i
    @t.kill if @t
    case @first_p
    when 1; exit
    end
    game
  end
#-------------------------------------------------------------------------------
end

game = ShougiApp.new
game.start
