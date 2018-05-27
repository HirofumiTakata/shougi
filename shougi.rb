class ShougiApp

  require './validations'
  require './methods'
  require './variable'
  include Validations
  include Methods
  include Variable

#----初期画面（選択していく画面）--------------------------------------
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
    @time_battle_switch = true
    hirate
  end

#------------------------------------------------------------------

#----将棋の盤・駒の表示-----------------------------------------------
  def game
    @count += 1
    #とりあえず。入玉や持駒の点数を確かめる必要がある。
    tied_game if 180 < @count
    @count.even? ? @fs = 1 : @fs = 2
    if @count == 0
      display_ban
    else
      @b = @b.reverse #先手後手で将棋盤を上下させる
      display_ban
    end
    phase_1
  end
#------------------------------------------------------------------

#----次のステージ（常時表示させて置くメッセージまたはタイマー）-------------
  def phase_1
    regular_message
    timer if @time_battle_switch
    phase_2
  end
#------------------------------------------------------------------

#----ステージ２(入力画面・入力終了時点でスレッドを削除）-------------------
  def phase_2
    m = method(:yellow_color)
    puts
    puts @space_3 * 2 + @message_g_1
    case @fs
    when 1
      unless @motigoma_1.empty?
        puts @space_3 * 2 + m.call(@message_g_3)
      end
    when 2
      unless @motigoma_2.empty?
        puts @space_3 * 2 + m.call(@message_g_3)
     end
    end
    @before_p = gets.to_i
    @t.kill if @t
    phase_3
  end
#------------------------------------------------------------------

#----ステージ３（入力の妥当性をチェック）--------------------------------
  def phase_3
    r = method(:red_color)
    outsider if @before_p == 4
    finish
    if @before_p < 11 || 99 < @before_p
      puts r.call(@error_1)
      @before_p = gets.to_i; phase_3
    elsif @before_p.to_s.include?("0") #20,30,40,50,60,70,80を除く
      puts r.call(@error_1)
      @before_p = gets.to_i; phase_3
    else
      validate_1
    end
      phase_4
  end
#------------------------------------------------------------------

#----ステージ４（選ばれた駒のチェック）---------------------------------
  def phase_4
    check_1
    #validate_2
    #validate_3
    phase_5
  end
#------------------------------------------------------------------

#----ステージ５（持駒があれば使用する選択肢を表示）-----------------------

#------------------------------------------------------------------

#----ステージ５（駒を配置する場所の入力）--------------------------------
  def phase_5
    puts @space_3 * 2 + "→ ＜\s#{@b[@before_p]}\s＞を置く位置を入力してください"
    puts @space_3 * 2 + @message_g_2 unless @time_battle_switch
    @after_p = gets.to_i
    phase_2 if @after_p == 3
    phase_6
  end
#------------------------------------------------------------------

#----ステージ６（入力の妥当性をチェック）--------------------------------
  def phase_6
    r = method(:red_color)
    finish
    if @after_p < 11 || 99 < @after_p
      puts r.call(@error_1)
      @after_p = gets.to_i; phase_7
    elsif @after_p.to_s.include?("0") #20,30,40,50,60,70,80を除く
      puts r.call(@error_1)
      @after_p = gets.to_i; phase_7
    else
      validate_3
    end
    phase_7
  end
#------------------------------------------------------------------

#----ステージ７（盤へ駒の描画）----------------------------------------
  def phase_7
    who_before = @b[@after_p]
    get_partner unless @b[@after_p] == "\s\s\s"
    @b[@after_p]  = @b[@before_p]
    zone_reverse if @after_p.to_s.match(/\d[123]/)
    @b[@before_p] = "\s\s\s"
    record(who_before)
    game
  end
#------------------------------------------------------------------

#----投了or終了-----------------------------------------------------
  def alert_window(message)
    log = caller
    @log.push(log).flatten!
    puts @space_3 + @box_line
    puts @space_3 + "|            " + message + "               |"
    puts @space_3 + "|             1 : YES   2: NO                   |"
    puts @space_3 + @box_line
    case gets.to_i
    when 1; exit
    when 2
      if @log[1].include?("2") #メソッドの呼び出し元が phase_2の場合
        @log.clear
        phase_2
      elsif @log[1].include?("6") #メソッドの呼び出し元が phase_6の場合
        @log.clear
        phase_6
      else
        phase_2
      end
    when 3; show_records
    else  ; exit
    end
  end
#------------------------------------------------------------------

#----持将棋による引き分け---------------------------------------------
  def tied_game
    puts @space_3 + @message_g_10
    exit
  end
#------------------------------------------------------------------
end

game = ShougiApp.new
game.start
