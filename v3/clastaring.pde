
int i, j;
int line;//行数　クラスタリングの番号
float a, b, c, d, e;
int R, G, B;       //赤、緑、青それぞれの値
float area[];      //それぞれのクラスタ番号の面積
float area_x[];    //それぞれのクラスタ番号のxの合計
float area_y[];    //それぞれのクラスタ番号のyの合計
int map[][];       //クラスタリング[x][y]
float minimum;
float dis[];       //前回の重心からの距離
int gg;            //今回の重心の位置(番号）
int I;             //何個あるか
float dis_min;     //最小距離
float m;           //重心の個数
float ce_x, ce_y;  //重心の座標




PImage Clustering(PImage img)
{
  //初期化
  line = 1;
  a = 0;
  for ( i = 0; i < 2000; i++)
  {
    area[i] = 0;
    area_x[i] = 0;
    area_y[i] = 0;
    dis[i] = 1000;
  }

  for ( i = 0; i < img.height; i++)
  {
    for ( j = 0; j < img.width; j++)
    {
      //ビデオのピクセルを取り出す
      color pixelColor = img.pixels[i*img.width + j];

      //赤、緑、青をそれぞれ抽出する(ビットシフト)
      R = (pixelColor >> 16) & 0xff;
      G = (pixelColor >> 8 ) & 0xff;
      B =  pixelColor        & 0xff;

      if (0.298912*R + 0.586611*G + 0.114478*B < 50)
      {
        img.pixels[i*img.width + j] = color(0, 0, 255);
        map[j][i] = line;
        if (a == 0) line++;
        a = 1;
      } else
      {
        //ウィンドウにピクセルを当てはめる
        img.pixels[i*img.width + j] = color(R, G, B);
        map[j][i] = 0;
        a = 0;
      }
    }
  }
  for (int i = 1; i<= img.height -2; i++)
    ///////////////////////右上から左下へ
  {
    for (j = 1; j < img.width-2; j++)
    {
      a=map[j][i];//中心のpixel
      b=map[j][i-1];//上のpixel
      c=map[j-1][i];//左のpixel
      d=map[j][i+1];//下のpixel
      e=map[j+1][i];//右のpixel
      if (a != 0 &&
        b != 0 &&
        c != 0 &&
        d != 0 &&
        e != 0)
      {
        minimum = a;
        if (minimum >= b) minimum = b;
        if (minimum >= c) minimum = c;
        if (minimum >= d) minimum = d;
        if (minimum >= e) minimum = e;
        map[j][i]   = (int)minimum;
        map[j][i-1] = (int)minimum;
        map[j-1][i] = (int)minimum;
        map[j][i+1] = (int)minimum;
        map[j+1][i] = (int)minimum;
      }
    }
  }
  //////////////右下から左上へ
  for (i = img.height-2; i >= 1; i--)
  {
    for (j = img.width-2; j >= 1; j--)
    {
      a=map[j][i];//中心のpixel
      b=map[j][i-1];//上のpixel
      c=map[j-1][i];//左のpixel
      d=map[j][i+1];//下のpixel
      e=map[j+1][i];//右のpixel
      if (a != 0 &&
        b != 0 &&
        c != 0 &&
        d != 0 &&
        e != 0)
      {
        minimum = a;
        if (minimum >= b) minimum = b;
        if (minimum >= c) minimum = c;
        if (minimum >= d) minimum = d;
        if (minimum >= e) minimum = e;
        map[j][i]   = (int)minimum;
        map[j][i-1] = (int)minimum;
        map[j-1][i] = (int)minimum;
        map[j][i+1] = (int)minimum;
        map[j+1][i] = (int)minimum;
      }
    }
  }
 for(i = 0; i<= img.height; i++){//各物体の面積を求める

    for ( j = 0; j < img.width; j++)
    {
      if (map[j][i] >= 2000)
      {
        //エラー回避
      } else if (map[j][i] > 0)
      {
        area[map[j][i]]++;          //面積をインクリメントする
        area_x[map[j][i]] += j;     //x座標の合計を求める
        area_y[map[j][i]] += i;     //y座標の合計を求める
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////
  //重心計算
  ////////////////////////////////////////////////////////////////////////////////////

  /////////////////面積が大きい順に並び替える
  for (i = 0; i < 2000; i++)
  {
    for ( j = 1+i; j < 2000; j++)
    {
      if (area[i] < area[j])
      {
        a = area[i];
        c = area_x[i];
        d = area_y[i];

        area[i] = area[j];
        area_x[i] = area_x[j];
        area_y[i] = area_y[j];

        area[j] = a;
        area_x[j] = c;
        area_y[j] = d;
      }
    }
  }
  /////////////////それぞれの重心の座標を求める
  for ( i = 0; i < 2000; i++ )
  {
    if (area[i] <= 50)
    {
      I = i;
      break;
    }
    area_x[i] /= area[i];
    area_y[i] /= area[i];
  }
  ///////////////重心の距離を求める
  a = int(ce_x);
  b = int(ce_y);
  for ( i = 0; i <= I; i++)
  {
    c = area_x[i];
    d = area_y[i];
    dis[i] = int(dist(a, b, c, d));
  }


  ///////////////マウス操作によって割り込みをする
  if (mousePressed == true & (mouseButton == LEFT))
  {
    for (i = 0; i <= I; i++)
    {
      a=mouseX;
      b=mouseY;
      c = area_x[i];
      d = area_y[i];
      dis[i]=int( dist(a, b, c, d) );
    }
  }

  ///////////////距離が短い方が重心
  dis_min = dis[0];
  gg = 0;
  for (i = 1; i < I; i++)
  {
    if (dis_min > dis[i])
    {
      dis_min = dis[i];  //最小
      gg = i;            //何番目か
    }
  }

  /////////////重心が決定
  ce_x = area_x[gg];
  ce_y = area_y[gg];
  m = area[gg];
  println(ce_x);
  return(img);
}
