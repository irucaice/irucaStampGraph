//Stampに関するクラス
class StampInfo {
  PImage img;
  int posX;
  int posY;
  StampInfo(int n) {
    if (n<10) {
      img = loadImage("data/0"+n+".png");
    } else if (10<=n) {
      img = loadImage("data/"+n+".png");
    }
  }
}


void listDraw(StampInfo[] stamp) {
  pushMatrix();
  scale(0.25);
  for ( int i=0; i<40; i++ ) {
    if (i<10) stamplist.image(iruca[i].img, 20+350*i, 0);
    if (10<=i && i<20) stamplist.image(stamp[i].img, 20+350*(i-10), 300);
    if (20<=i && i<30) stamplist.image(stamp[i].img, 20+350*(i-20), 600);
    if (30<=i && i<40) stamplist.image(stamp[i].img, 20+350*(i-30), 900);
  }
  popMatrix();
}

