module Variable
#---初期化-----------------------------------------------------------------------
  def initialize
    @count = -1
    @fs    = 1
    @log   = []
    @time_battle_switch = false


#---最初の選択画面のメッセージ------------------------------------------------------
    @box_line        = '+-----------------------------------------------+'

    @message_1_1     = "|  １：ゲームをする                             |"
    @message_1_2     = "|  ２：終了する                                 |"

    @message_2_1     = "|  １：ゲームスタート！                         |"
    @message_2_2     = "|  ２：オプション                               |"
    @message_2_3     = "|  ３：スタート画面に戻る                       |"

    @message_2_2_1   = "|  １：一枚落ちでハンデをつける                 |"
    @message_2_2_2   = "|  ２：二枚落ちでハンデをつける                 |"
    @message_2_2_3   = "|  ３：四枚落ちでハンデをつける                 |"
    @message_2_2_4   = "|  ４：六枚落ちでハンデをつける                 |"
    @message_2_2_5   = "|  ５：早指し将棋（３０秒切り負け戦）           |"
    @message_2_2_6   = "|  ６：前の画面に戻る                           |"

    @message_2_2_1_1 = "|  １：先手＜飛車＞落ち                         |"
    @message_2_2_1_2 = "|  ２：後手＜飛車＞落ち                         |"
    @message_2_2_1_3 = "|  ３：先手＜角行＞落ち                         |"
    @message_2_2_1_4 = "|  ４：後手＜角行＞落ち                         |"
    @message_2_2_1_5 = "|  ５：選択画面へ戻る                           |"

    @message_2_2_2_1 = "|  １：先手＜飛車＞＜角行＞落ち                 |"
    @message_2_2_2_2 = "|  ２：後手＜飛車＞＜角行＞落ち                 |"
    @message_2_2_2_3 = "|  ３：選択画面へ戻る                           |"

    @message_2_2_3_1 = "|  １：先手＜飛車＞＜角行＞＜香車＞落ち         |"
    @message_2_2_3_2 = "|  ２：後手＜飛車＞＜角行＞＜香車＞落ち         |"
    @message_2_2_3_3 = "|  ３：選択画面へ戻る                           |"

    @message_2_2_4_1 = "|  １：先手＜飛車＞＜角行＞＜香車＞＜桂馬＞落ち |"
    @message_2_2_4_2 = "|  ２：後手＜飛車＞＜角行＞＜香車＞＜桂馬＞落ち |"
    @message_2_2_4_3 = "|  ３：選択画面へ戻る                           |"
#-------------------------------------------------------------------------------

#----常時表示させておくメッセージ---------------------------------------------------
    @message_r_1     = "１：投了する\s\s２：終了する"
    @message_r_2     = "持ち時間：" #timer用
#------------------------------------------------------------------------------

#---将棋盤の構成要素。初期値はスペース３つ分------------------------------------------
    @space_3    = "\s\s\s"
    @line_1     = "\e[33m+---+---+---+---+---+---+---+---+---+\e[0m"

    @b = Array.new(111)
    @b.fill("\s\s\s")
#-------------------------------------------------------------------------------

#----持駒-----------------------------------------------------------------------
  @motigoma_1 = [] #先手
  @motigoma_2 = [] #後手
#-------------------------------------------------------------------------------

#----駒の配置関連-----------------------------------------------------------------
  @ahead      = []
  @x          = []
  @cross      = []
  @gold_2     = []
  @jump_2     = []
#-------------------------------------------------------------------------------

#----ゲーム内でのメッセージ--------------------------------------------------------
  @message_g_1     = "→ 動かしたい駒の位置を入力してください"
  @message_g_2     = "\s\s３：駒を変更する。"
  @message_g_3     = "４：持駒を使用する"
  @message_g_6     = "持将棋です。引き分けになります。お疲れ様でした！"
#------------------------------------------------------------------------------

#----ゲーム内でのメッセージ--------------------------------------------------------
  @error_1    = "＊符号「１１」から「９９」までの数値を入力してください＊"
  @error_2    = "＊自分の駒を選択して下さい＊"
  @error_3    = "＊この駒は動かすことができません＊"
#-------------------------------------------------------------------------------
  end
#---初期化終了ライン--------------------------------------------------------------
end
