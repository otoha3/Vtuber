import processing.sound.*;
 import processing.video.*;

Capture cap;

PImage img1;
//マイク
AudioIn in;
//音量を取得してくれるもの
Amplitude amp;
 
//ウインドウのサイズ
int SCREEN_SIZE = 500;
 
PImage fase;
int rotFase;
 
PImage[] mouth;
int mouthNum;
boolean mouthCount;
boolean mouthTime;
 
PImage[] eye;
int eyeNum;
int eyeRandom;
boolean eyeTime;
boolean eyeCount;
double eyeTimer;
 
PImage leftFoot;
PImage rightFoot;
PImage body;
 
PImage rightHand;
PImage leftHand;
int rotRigthHand;
int rotLeftHand;
 
 PImage hair;
 
PImage tail;
 
 
void setup() {
  
  
  frameRate(60);
  PFont font = createFont("Yu Gothic",64,true);
  textFont(font);
  /////////////
    area = new float[2000];
  area_x = new float[2000];
  area_y = new float[2000];
  dis = new float[2000];
  //map = new int[320][240];
    map = new int[1000][1000];
  ce_x = 160;
  ce_y = 120;
  
  frameRate(60);
  String[] cameras = Capture.list();
  for (i = 0; i < cameras.length; i++)
  {
    println(cameras[i]);
  }
  ///////////////////カメラ関係
  cap = new Capture(this, 320, 240);
  cap.start();
  loadPixels();
  
    /////////////
  
  size(820,500);
  
  //マイク設定
  in = new AudioIn(this);
  in.start();
  
  // 音量の取得を開始
  amp = new Amplitude(this);
  amp.input(in);
  
  
  //目の処理
  eyeNum = 0;
  eyeCount = true;
  eyeTimer = millis();
  eyeRandom = 0;
  eye = new PImage[5];
  eye[0] = loadImage ("eye.png");
  eye[1] = loadImage ("eye1.png");
  eye[2] = loadImage ("eye2.png");
  eye[3] = loadImage ("eye3.png");
  eye[4] = loadImage ("eye4.png");
  
  mouthNum = 0;
  mouthCount = true;
  mouth = new PImage[4];
  mouth[0] = loadImage("mouth4.png");
  mouth[1] = loadImage("mouth1.png");
  mouth[2] = loadImage("mouth2.png");
  mouth[3] = loadImage("mouth3.png");
  //mouth[4] = loadImage("mouth3.png");
    
  fase = loadImage ("face.png");
  rotFase = 1;
  
  body = loadImage("body.png");
  
  rightHand = loadImage("rightHand.png");
  leftHand = loadImage("leftHand.png");
  rotRigthHand = 0;
  rotLeftHand = 0;
  
  leftFoot = loadImage("leftFoot.png");
  rightFoot = loadImage("rightFoot.png");
  hair = loadImage("hair.png");
  tail = loadImage("tail.png");
  
   
  
}
 
void draw() {
  
  
  //目の処理
  eyeAnimation();
  
  //口の処理
  mouthAnimation();
  
  background(224,214,255);
  
  
  //体と手の処理

      bodyAnimation();
  //顔の処理
  faseAnimation();
  momiAnimation();

  
    //尻尾の処理
// tailAnimation();
  //image(rightFoot,0,0,SCREEN_SIZE,SCREEN_SIZE);
  //image(leftFoot,0,0,SCREEN_SIZE,SCREEN_SIZE);
  
  
  
  //////////
    if (cap.available() == true)////読み込み成功
  {
    cap.read();          //カメラからの画像を読み込む

    img1 = Clustering((PImage)cap);
    
    //(PImage)cap;
  }

  if (img1 != null)
  {
    image(img1, 500, 0);
    Clustering(img1);
  }
}
 
