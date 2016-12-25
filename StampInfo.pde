//Stampに関するクラス
class StampInfo {
  PImage img;
  int posX;
  int posY;
  int no;
  int year;
  int month;
  int day;
  int sent;
  int total;

  //[40][day_number]用のコンストラクタ
  StampInfo() {
  }

  //[40]用のコンストラクタ
  StampInfo(int n) {
    no = n+1; //スタンプ番号
    total = 0; //合計送信数
    //----画像を登録-----------------------
    if (n<9) {
      img = loadImage("data/0"+(n+1)+".png");
    } else if (9<=n) {
      img = loadImage("data/"+(n+1)+".png");
    }
    //---座標を登録------------------------
    if (n<10) {
      posX = 20+350*n;
      posY = 1500;
    }
    if (10<=n && n<20) {
      posX = 50+350*(n-10);
      posY = 1800;
    }
    if (20<=n && n<30) {
      posX = 50+350*(n-20);
      posY = 2100;
    }
    if (30<=n && n<40) {
      posX = 50+350*(n-30);
      posY = 2400;
    }
  }

  void setData(int _no, int _year, int _month, int _day, int _sent) {
    no = _no;
    year = _year;
    month = _month;
    day = _day;
    sent = _sent;
  }
}


void listDraw() {
  //-------------画像を縮小して表示---------------------
  pushMatrix();
  scale(0.25);
  for ( int i=0; i<40; i++ ) {
    image(iruca[i].img, iruca[i].posX, iruca[i].posY);
  }
  popMatrix();
}

//スタンプアイコンの上にカーソルを合わせた時
void cursorOnIcon() {
  for ( int i=0; i<40; i++ ) {
    if ( (iruca[i].posX)/4<mouseX && mouseX<(iruca[i].posX+350)/4 && (iruca[i].posY)/4<mouseY && mouseY<(iruca[i].posY+300)/4 ) {
      //カーソルに合っているアイコンに四角を表示
      fill(200, 210, 255, 100);
      rect((iruca[i].posX)/4-8, (iruca[i].posY)/4-8, 100, 100);
      if (select==-1) {
        selectInTotal = i;
      }
    }
  }
}

//背景に選択しているスタンプを表示
void backImage(int num){
  tint(255, 255, 255, 50);
  if(0<=num) image(iruca[num].img, 300, 20);
  noTint();
}

//左上に番号を表示
void Number(int num){
  textSize(30);
  fill(0);
  if(0<=num) text("No." + iruca[num].no, 30, 50);
}
