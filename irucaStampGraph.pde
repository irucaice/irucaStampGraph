/*
　　【システムの概要】
    ・2015/05/24〜2015/07/21の一日ごとのの送信数を折れ線グラフで閲覧可能
    ・種類別の合計送信数を棒グラフで表示
    
   【UIの説明】
    ・各スタンプアイコンをクリックすると、そのスタンプの一日ごとの送信数を折れ線グラフで表示
    ・右上のtotalボタンをクリックすると種類別の合計送信数を棒グラフで表示
    ・棒グラフを表示している時、棒グラフまたはスタンプアイコンにカーソルを合わせると、対象の棒を着色
 */

import de.bezier.data.sql.*; //Load library
SQLite db;

int day_number = 59;
StampInfo [] iruca = new StampInfo [40];
StampInfo [][] stampData = new StampInfo [40][day_number];
Button totalButton = new Button(780, 18, "total");

int select = 0;
int selectInTotal = -1;
int barY = 330; //グラフのアンダーバーの位置

void setup() {
  size(900, 700);
  db = new SQLite(this, "data/stamp.sqlite"); //open DB file
  for ( int i=0; i<40; i++ ) {  //スタンプ40個を初期化
    iruca[i] = new StampInfo(i);
    for ( int j=0; j<59; j++ ) {
      stampData[i][j] = new StampInfo();
    }
  }

  if (db.connect()) {
    println("---------------------------------------------------------------");

    // stampテーブルから情報を取得
    String sql =  "SELECT no,year,month,day,sent FROM stamp";
    db.query( sql ); //sqlを実行する

    int NumCount = 0;
    int DayCount = 0;
    while ( db.next () ) { // db.next() == true なら次の結果があるということ
      println( db.getInt( "no" ) + "番の" + db.getInt( "year" ) +"年"+ db.getInt( "month" ) +"月" + db.getInt( "day" ) +"日の送信数は" + db.getInt( "sent" ) +"です。");

      stampData[NumCount][DayCount].setData( db.getInt( "no" ), db.getInt( "year" ), db.getInt( "month" ), db.getInt( "day" ), db.getInt( "sent" ) );
      //１〜59まで入れていって全日数入れ終わったら次のスタンプの1〜59までいれて...の繰り返し
      if (DayCount==58) {
        NumCount++; 
        DayCount = 0;
      } else {
        DayCount++;
      }
    }
  } else {
    println("Connect Error");
  }

  for ( int i=0; i<40; i++ ) {  //スタンプの合計送信数を格納していく
    for ( int j=0; j<59; j++ ) {
      iruca[i].total += stampData[i][j].sent;
    }
  }
}

//---------------------------------------------------------------
void draw() {
  background(255);
  drawGraph(select);  //グラフを表示
  totalButton.draw();  //合計ボタンを表示
  cursorOnIcon();  //アイコンにカーソルを合わせた時
  listDraw();  //スタンプリストを表示
}

//---------------------------------------------------------------

void drawGraph(int select) {
  if (select==-1) {
    totalBarGraph();
  } else {
    lineGraph(select);
  }
}

//折れ線グラフ
void lineGraph(int stampNum) {
  //背景に選択しているスタンプを表示
  backImage(stampNum);

  //スタンプ番号を表示
  Number(stampNum);

  //トータル送信数を表示
  textSize(30);
  fill(0);
  text("total:" + iruca[stampNum].total, 620, 50);

  for ( int j=0; j<59; j++ ) {
    textSize(16);
    fill(0);
    ellipse(45+j*14, barY-stampData[stampNum][j].sent*5, 4, 4); //点を打っていく
    textSize(12);
    text(stampData[stampNum][j].sent, 45+j*14, barY-stampData[stampNum][j].sent*5-5);//点の上に送信数を表示
    stroke(0);
    if (j<58) line(45+j*14, barY-stampData[stampNum][j].sent*5, 45+(j+1)*14, barY-stampData[stampNum][j+1].sent*5); //線でつないでいく
  }

  //日付を表示
  line(45, barY, 855, barY);
  textSize(16);
  text(stampData[0][0].year, 30, barY+18);
  text(stampData[0][0].month+"/"+stampData[0][0].day, 30, barY+34);
  text(stampData[0][58].year, 850, barY+18);
  text(stampData[0][58].month+"/"+stampData[0][58].day, 850, barY+34);
}

//種類別合計送信数の棒グラフ
void totalBarGraph() {
  //背景に選択しているスタンプを表示
  backImage(selectInTotal);

  //スタンプ番号を表示
  Number(selectInTotal);

  line(45, barY, 855, barY);
  for (int i=0; i<40; i++) {
    //棒の表示
    noStroke();
    fill(150, 150, 255);
    //カーソルの合っているスタンプの棒を着色
    if (selectInTotal==i) {
      fill(255, 170, 170);
    }
    rect(55+i*20, barY, 10, -0.2*iruca[i].total);
    
    if(55+i*20<mouseX && mouseX<65+i*20 && barY-0.2*iruca[i].total<mouseY && mouseY<barY){
      selectInTotal = i;
    }
    
    //種類別合計送信数の表示
    fill(0);
    textSize(12);
    text(iruca[i].total, 50+i*20, barY-0.2*iruca[i].total-2);
    //Np.1-40の目盛りを表示
    textSize(10);
    text(i+1, 54+i*20, barY+10);
  }
}

void mousePressed() {
  //いるかアイコンをクリックしたら
  for ( int i=0; i<40; i++ ) {
    if ( (iruca[i].posX)/4<mouseX && mouseX<(iruca[i].posX+350)/4 && (iruca[i].posY)/4<mouseY && mouseY<(iruca[i].posY+300)/4 ) {
      select = i;
    }
  }

  //totalボタンをクリックしたら
  if (totalButton.posX<mouseX && mouseX<totalButton.posX+totalButton.boxWidth && totalButton.posY<mouseY && mouseY<totalButton.posY+totalButton.boxHeight) {
    select = -1;
  }
}

