class Button {
  int posX;
  int posY;
  String text;
  int boxWidth;
  int boxHeight;

  Button(int _posX, int _posY, String _text) {
    posX = _posX;
    posY = _posY;
    text = _text;
    boxWidth =100;
    boxHeight = 40;
  }

  void draw() {
    fill(200, 210, 255, 100);
    if(posX<mouseX && mouseX<posX+boxWidth && posY<mouseY && mouseY<posY+boxHeight){
          fill(200, 210, 255);
    }
    stroke(0);
    rect(posX, posY, boxWidth, boxHeight);
    textSize(30);
    fill(0);
    text(text, posX+18, posY+30);
  }
}

