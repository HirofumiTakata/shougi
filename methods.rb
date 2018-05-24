module Methods
#---将棋の盤の表示----------------------------------------------------------------
  def display_ban

    [91,81,71,61,51,41,31,21,11].each { |n| @line_1_1 << "|" + @b[n] }
    [92,82,72,62,52,42,32,22,12].each { |n| @line_1_2 << "|" + @b[n] }
    [93,83,73,63,53,43,33,23,13].each { |n| @line_1_3 << "|" + @b[n] }
    [94,84,74,64,54,44,34,24,14].each { |n| @line_1_4 << "|" + @b[n] }
    [95,85,75,65,55,45,35,25,15].each { |n| @line_1_5 << "|" + @b[n] }
    [96,86,76,66,56,46,36,26,16].each { |n| @line_1_6 << "|" + @b[n] }
    [97,87,77,67,57,47,37,27,17].each { |n| @line_1_7 << "|" + @b[n] }
    [98,88,78,68,58,48,38,28,18].each { |n| @line_1_8 << "|" + @b[n] }
    [99,89,79,69,59,49,39,29,19].each { |n| @line_1_9 << "|" + @b[n] }

    @shougi_ban = <<-DISPLAY
        9   8   7   6   5   4   3   2   1
      #{@line_1}
      #{@line_1_1}| 一
      #{@line_1}
      #{@line_1_2}| 二
      #{@line_1}
      #{@line_1_3}| 三
      #{@line_1}
      #{@line_1_4}| 四
      #{@line_1}
      #{@line_1_5}| 五
      #{@line_1}
      #{@line_1_6}| 六
      #{@line_1}
      #{@line_1_7}| 七
      #{@line_1}
      #{@line_1_8}| 八
      #{@line_1}
      #{@line_1_9}| 九
      #{@line_1}
    DISPLAY

    puts @shougi_ban
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
#-------------------------------------------------------------------------------

#----将棋盤へ駒の描画（ハンデ戦１０のパターンを含む）-----------------------------------
  def standard
    # 後手陣のコマ
    [71, 31].each { |n| @b[n] = "^銀" }
    [61, 41].each { |n| @b[n] = "^金" }
    [93, 83, 73, 63, 53, 43, 33, 23, 13].each { |n| @b[n] = "^歩" }
    # 先手陣のコマ
    [97, 87, 77, 67, 57, 47, 37, 27, 17].each { |n| @b[n] = "歩\s" }
    [79, 39].each { |n| @b[n] = "銀\s" }
    [69, 49].each { |n| @b[n] = "金\s" }
    return
  end

  def kyousha
    # 後手陣のコマ
    [91, 11].each { |n| @b[n] = "^香" }
    # 先手陣のコマ
    [99, 19].each { |n| @b[n] = "香\s" }
    return
  end

  def keima
    # 後手陣のコマ
    [81, 21].each { |n| @b[n] = "^桂" }
    # 先手陣のコマ
    [89, 29].each { |n| @b[n] = "桂\s" }
    return
  end

  def handicap_6_1
    standard
    # 後手陣のコマ
    [91, 11].each { |n| @b[n] = "^香" }
    [81, 21].each { |n| @b[n] = "^桂" }
    @b[51] = "^玉"
    @b[22] = "^角"
    @b[82] = "^飛"
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_6_2
    standard
    # 後手陣のコマ
    @b[51] = "^王"
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
    kyousha
    # 後手陣のコマ
    [81, 21].each { |n| @b[n] = "^桂" }
    @b[51] = "^玉"
    @b[22] = "^角"
    @b[82] = "^飛"
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_4_2
    standard
    kyousha
    # 後手陣のコマ
    @b[51] = "^王"
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    [89, 29].each { |n| @b[n] = "桂\s" }
    game
  end

  def handicap_2_1
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = "^玉"
    @b[22] = "^角"
    @b[82] = "^飛"
    # 先手陣のコマ
    @b[59] = "王\s"
    game
  end

  def handicap_2_2
    standard
    kyousha
    keima
    # 後手陣のコマ
    @b[51] = "^王"
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
    @b[51] = "^玉"
    @b[22] = "^角"
    @b[82] = "^飛"
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
    @b[51] = "^王"
    @b[22] = "^角"
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
    @b[51] = "^玉"
    @b[22] = "^角"
    @b[82] = "^飛"
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
    @b[51] = "^王"
    @b[22] = "^角"
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
    @b[51] = "^王"
    @b[22] = "^角"
    @b[82] = "^飛"
    # 先手陣のコマ
    @b[88] = "角\s"
    @b[28] = "飛\s"
    @b[59] = "玉\s"
    game
  end
#-------------------------------------------------------------------------------

end
