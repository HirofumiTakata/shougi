module Methods

#----文字に色をつける------------------------------------------------
  def magenta_color(string)
    converter = "\e[35m\e[0m"
    converter.insert(5, string)
  end
#-----------------------------------------------------------------

#----文字に色をつける------------------------------------------------
  def red_color(string)
    converter = "\e[31m\e[0m"
    converter.insert(5, string)
  end
#-----------------------------------------------------------------

#----文字に色をつける------------------------------------------------
  def yellow_color(string)
    converter = "\e[33m\e[0m"
    converter.insert(5, string)
  end
#-----------------------------------------------------------------


#----文字と背景色を反転させる-----------------------------------------
  def reverse_color(string)
    converter = "\e[7m\e[0m"
    converter.insert(4, string)
  end
#-----------------------------------------------------------------

#----先手か後手かスクラムマスターか------------------------------------
  def fir_or_sec
    case @fs
    when 1; @message_fs = "＜ 先手 ＞"
    when 2; @message_fs = "＜ 後手 ＞"
    else  ; @message_fs = "＜ スクラムマスター ＞"
    end
  end
#------------------------------------------------------------------

#---将棋の盤の表示---------------------------------------------------
  def display_ban

    y_1 = ""
    y_2 = ""
    y_3 = ""
    y_4 = ""
    y_5 = ""
    y_6 = ""
    y_7 = ""
    y_8 = ""
    y_9 = ""

    @yl = "\e[33m|\e[0m"

    [91,81,71,61,51,41,31,21,11].each { |n| y_1 << @yl + @b[n] }
    [92,82,72,62,52,42,32,22,12].each { |n| y_2 << @yl + @b[n] }
    [93,83,73,63,53,43,33,23,13].each { |n| y_3 << @yl + @b[n] }
    [94,84,74,64,54,44,34,24,14].each { |n| y_4 << @yl + @b[n] }
    [95,85,75,65,55,45,35,25,15].each { |n| y_5 << @yl + @b[n] }
    [96,86,76,66,56,46,36,26,16].each { |n| y_6 << @yl + @b[n] }
    [97,87,77,67,57,47,37,27,17].each { |n| y_7 << @yl + @b[n] }
    [98,88,78,68,58,48,38,28,18].each { |n| y_8 << @yl + @b[n] }
    [99,89,79,69,59,49,39,29,19].each { |n| y_9 << @yl + @b[n] }

    shougi_ban = <<-DISPLAY
        9   8   7   6   5   4   3   2   1
      #{@line_1}
      #{y_1}#{@yl} 一
      #{@line_1}
      #{y_2}#{@yl} 二
      #{@line_1}
      #{y_3}#{@yl} 三
      #{@line_1}
      #{y_4}#{@yl} 四
      #{@line_1}
      #{y_5}#{@yl} 五
      #{@line_1}
      #{y_6}#{@yl} 六
      #{@line_1}
      #{y_7}#{@yl} 七
      #{@line_1}
      #{y_8}#{@yl} 八
      #{@line_1}
      #{y_9}#{@yl} 九
      #{@line_1}
    DISPLAY

    puts shougi_ban
    return

  end
=begin
  将棋盤の表示（初期設定の中身は半角スペース３つ分＼s＼s＼s）
    9   8   7   6   5   4   3   2   1
   +---+---+---+---+---+---+---+---+---+
   |91 |81 |71 |61 |51 |41 |31 |21 |11 | 一
   +---+---+---+---+---+---+---+---+---+
   |92 |82 |72 |62 |52 |42 |32 |22 |12 | 二
   +---+---+---+---+---+---+---+---+---+
   |93 |83 |73 |63 |53 |43 |33 |23 |13 | 三
   +---+---+---+---+---+---+---+---+---+
   |94 |84 |74 |64 |54 |44 |34 |24 |14 | 四
   +---+---+---+---+---+---+---+---+---+
   |95 |85 |75 |65 |55 |45 |35 |25 |15 | 五
   +---+---+---+---+---+---+---+---+---+
   |96 |86 |76 |66 |56 |46 |36 |26 |16 | 六
   +---+---+---+---+---+---+---+---+---+
   |97 |87 |77 |67 |57 |47 |37 |27 |17 | 七
   +---+---+---+---+---+---+---+---+---+
   |98 |88 |78 |68 |58 |48 |38 |28 |18 | 八
   +---+---+---+---+---+---+---+---+---+
   |99 |89 |79 |69 |59 |49 |39 |29 |19 | 九
   +---+---+---+---+---+---+---+---+---+
=end
#-----------------------------------------------------------------

#----将棋盤へ駒の描画（ハンデ戦１０のパターンを含む）---------------------
  def standard
    @m = method(:magenta_color)
    # 後手陣のコマ
    [71, 31].each { |n| @b[n] = @m.call("#銀") }
    [61, 41].each { |n| @b[n] = @m.call("#金") }
    [93, 83, 73, 63, 53, 43, 33, 23, 13].each do |n|
      @b[n] = @m.call("#歩")
    end
    # 先手陣のコマ
    [97, 87, 77, 67, 57, 47, 37, 27, 17].each do |n|
      @b[n] = "歩\s"
    end
    [79, 39].each { |n| @b[n] = "銀\s" }
    [69, 49].each { |n| @b[n] = "金\s" }
    return
  end

  def kyousha
    # 後手陣のコマ
    [91, 11].each { |n| @b[n] = @m.call("#香") }
    # 先手陣のコマ
    [99, 19].each { |n| @b[n] = "香\s" }
    return
  end

  def keima
    # 後手陣のコマ
    [81, 21].each { |n| @b[n] = @m.call("#桂") }
    # 先手陣のコマ
    [89, 29].each { |n| @b[n] = "桂\s" }
    return
  end

  def handicap_6_1
    standard
    # 後手陣のコマ
    [91, 11].each { |n| @b[n] = @m.call("#香") }
    [81, 21].each { |n| @b[n] = @m.call("#桂") }
    @b[51] = @m.call("#玉")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_6_2
    standard
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    [99, 19].each { |n| @b[n] = "香\s" }
    [89, 29].each { |n| @b[n] = "桂\s" }
    @b[59] = "玉\s"
    game
  end

  def handicap_4_1
    standard
    keima
    # 後手陣のコマ
    [91, 11].each { |n| @b[n] = @m.call("#香") }
    @b[51] = @m.call("#玉")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_4_2
    standard
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    [99, 19].each { |n| @b[n] = "香\s" }
    game
  end

  def handicap_2_1
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#玉")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_2_2
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    game
  end

  def handicap_1_1f
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#玉")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[59] = "王\s"
    game
  end

  def handicap_1_2f
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    @b[22] = @m.call("#角")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    game
  end

  def handicap_1_1h
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#玉")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[28] = "飛\s"
    @b[59] = "王\s"
    game
  end

  def handicap_1_2h
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    @b[22] = @m.call("#角")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    game
  end

  def hirate
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = @m.call("#王")
    @b[22] = @m.call("#角")
    @b[82] = @m.call("#飛")
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    game
  end
#-----------------------------------------------------------------

#----常時表示させておくメッセージ--------------------------------------
  def regular_message
    m = method(:fir_or_sec)
    puts
    puts @space_3 * 2 + m.call + "\s" + @message_r_1
    unless @motigoma_1.empty? && @motigoma_2.empty?
      puts @space_3 * 2 + "先手持駒\s#{@motigoma_1}"
      puts @space_3 * 2 + "後手持駒\s#{@motigoma_2}"
    end
  end
#-----------------------------------------------------------------

#----Timer表示-----------------------------------------------------
  def display_time
      [*(11..30)].reverse.each do |t|
        sleep(1)
        print @space_3 * 2 + @message_r_2 + "#{t}\r"
      end
      [*(0..9),"十秒前！！"].reverse.each do |t|
        sleep(1)
        print @space_3 * 3 + "#{t}\r"
      end
  end
#-----------------------------------------------------------------

#----Timer（持ち時間）早打ち将棋--------------------------------------
  def timer
    @t = Thread.new do
    time_start = Time.new
    limit      = time_start + 30
    display_time
    loop do
      progress = Time.new
      next unless limit < progress
      puts "\n\n"
      puts @space_3 * 4 + "＜＜ タイムアウト！！ ＞＞"
      puts
      break
    end
    end
  end
#-----------------------------------------------------------------

#----持駒を獲得（持駒変数へ駒を格納）-----------------------------------
  def get_partner
    #獲得した駒が成駒だった場合、元（なる前の状態）に戻す。
    case @fs
    when 1
      @motigoma_1 << @b[@after_p].gsub(/[^\p{Han}\p{Hiragana}]/, "")
    when 2
      @motigoma_2 << @b[@after_p].gsub(/\s/, "")
    else
    end
  end
#-----------------------------------------------------------------

#----持駒を使用する際の表示-------------------------------------------
  def outsider
    case @fs
    when 1; show_motigoma(@motigoma_1)
    when 2; show_motigoma(@motigoma_2)
    end
  end

  def show_motigoma(motigoma)
    @motigoma_list = []
    m = method(:yellow_color)
    i = 0
    motigoma.each.with_index(1) do |k, i|
      @motigoma_list << "#{i}：#{k}"
    end
    puts @space_3 + m.call(@box_line)
    while @motigoma_list[i] do
      puts @space_3 * 2 + @motigoma_list[i..(i + 4)].join("\s")
      i += 4
    end
    puts @space_3 * 2 + @message_g_4
    puts @space_3 + m.call(@box_line)
    choice_motigoma
  end
#-----------------------------------------------------------------

#----持駒を選択する-------------------------------------------------
  def choice_motigoma
    choice = gets.to_i
    max    = @motigoma_list.length
    r      = method(:red_color)
    if choice == 0
      phase_2
    elsif choice < 1 || max < choice
      puts r.call("＊１〜#{max}までの数値を入力して下さい＊")
      choice_motigoma
    else
      phase_2
    end
    @manage_outsider = choice + 1
    deploy_player
  end
#-----------------------------------------------------------------

#----終了コマンド---------------------------------------------------
  def finish
    if @before_p == 1 || @after_p == 1
      alert_window("本当に投了しますか？")
    elsif @before_p == 2 || @after_p == 2
      alert_window("本当に終了しますか？")
    else
    end
  end
#-----------------------------------------------------------------


end
