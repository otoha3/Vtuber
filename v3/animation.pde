

 
//体を動かす
void bodyAnimation() {


  //マウスのx座標で回転させるようにセット
  //これは仮設定です
  rotFase = (int(ce_x)*2 - SCREEN_SIZE/2)/25;
    //rotFase = (mouseX - SCREEN_SIZE/2)/25;
    
   
  
  //座標軸変更
  translate(SCREEN_SIZE*0.43, SCREEN_SIZE*9/10);
  
  //座標回転
  rotate(PI * rotFase / 600);
  
  
  //腕の表示
  //※腕を動かすならアニメーションにした方が良さげという結論に至る
  image(rightHand,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
  image(leftHand,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
  
  //体の表示
  image(body,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
 // image(tail,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
    //  image(tail,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
  
  
  //座標軸の初期化
  resetMatrix();
}
 
//頭を動かす
void faseAnimation() {
  
  //座標を移動させる
  translate(SCREEN_SIZE*0.43, SCREEN_SIZE*3/5);
  
  //座標回転
  rotate(PI * rotFase / 600);
  
  //顔、目、口の表示
  image(fase,SCREEN_SIZE*-0.43+rotFase*2*SCREEN_SIZE/500,SCREEN_SIZE*-3/5,SCREEN_SIZE,SCREEN_SIZE);
  image(eye[eyeNum],SCREEN_SIZE*-0.43+rotFase*2*SCREEN_SIZE/500,SCREEN_SIZE*-3/5,SCREEN_SIZE,SCREEN_SIZE);
  image(mouth[mouthNum],SCREEN_SIZE*-0.43+rotFase*2*SCREEN_SIZE/500,SCREEN_SIZE*-3/5,SCREEN_SIZE,SCREEN_SIZE);
  image(hair,SCREEN_SIZE*-0.43+rotFase*2*SCREEN_SIZE/500,SCREEN_SIZE*-3/5,SCREEN_SIZE,SCREEN_SIZE);

  //座標軸の初期化
  resetMatrix();
}
 
//口のアニメーション
void mouthAnimation() {
 
  
  //マイクからの音声入力で反応する
  if(amp.analyze() * 1000 > 100)
  {
    mouthTime = true;
  }
  
  //口パク実行
  if(mouthTime) {
    
    //口を開ける
    if(mouthCount && mouthNum < mouth.length){
      mouthNum++;
    }
  
    //口を閉じる
    if(!mouthCount && mouthNum > 0){
      mouthNum--;
    
      //口パク終了
      if(mouthNum == 0) {
        mouthTime = false;
        mouthCount = true;
      }
    }
  
    //口が完全に開いた
    if(mouthNum == mouth.length-1){
      mouthCount = false; 
    }
  }
}
 
//目のアニメーション
void eyeAnimation() {
  
  //瞬きする時間間隔判定
  if((millis() - eyeTimer)/1000  > eyeRandom)
  {
    eyeTime = true;
  }
  
  //瞬き実行
  if(eyeTime) {
    
    //目を閉じる
    if(eyeCount && eyeNum < eye.length){
      eyeNum++;
    }
  
    //目を開ける
    if(!eyeCount && eyeNum > 0){
      eyeNum--;
    
      //瞬き終了
      if(eyeNum == 0) {
        eyeTime = false;
        eyeCount = true;
        eyeTimer = millis();
        eyeRandom = int(random(21)) + 10;
      }
    }
  
    //目が完全に閉じた
    if(eyeNum == eye.length-1){
      eyeCount = false; 
    }
  }
}

////尻尾を動かす
///*
//void tailAnimation() {
  
//  //座標軸変更
//  translate(SCREEN_SIZE*0.43, SCREEN_SIZE*4/5);
  
//  rotate(PI * (-rotFase*1.5 + 10) / 500);
  
//  image(tail,SCREEN_SIZE*-0.43, SCREEN_SIZE*-4/5,SCREEN_SIZE,SCREEN_SIZE);
  
//  //座標軸の初期化
//  resetMatrix();
//}

void momiAnimation(){
    rotFase = (int(ce_x)*2 - SCREEN_SIZE/2)/25;
    //rotFase = (mouseX - SCREEN_SIZE/2)/25;
    
   
  
  //座標軸変更
  translate(SCREEN_SIZE*0.43, SCREEN_SIZE*9/10);
  
  //座標回転
  rotate(PI * rotFase / 350);
  

      image(tail,SCREEN_SIZE*-0.43, SCREEN_SIZE*-9/10,SCREEN_SIZE,SCREEN_SIZE);
  
  
  //座標軸の初期化
  resetMatrix();
}
