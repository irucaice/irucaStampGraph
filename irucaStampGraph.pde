int canvas_width = 900;
int canvas_height = 700;
PGraphics canvas;
PGraphics stamplist;

StampInfo [] iruca = new StampInfo [40];

void setup() {
  canvas = createGraphics(canvas_width, 370);  //グラフを表示する画面
  stamplist = createGraphics(canvas_width, 330);  //スタンプリストを表示する画面
  size(canvas_width, canvas_height);
  for ( int i=0; i<40; i++ ) {  //スタンプ40個を初期化
    iruca[i] = new StampInfo(i+1);
  }
}

//---------------------------------------------------------------
void draw() {
  background(255);
  line(0, 370, width, 370);
  stamplist.beginDraw();
  listDraw(iruca);
  stamplist.endDraw();
  image(stamplist,0,370);
}

//---------------------------------------------------------------

