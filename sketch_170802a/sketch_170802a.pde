int i, j;
float dx=0, dy=0;
int N=50,R=0,G=0,B=0,mode=1,cnt;

float[] cx = new float[10];
float[] cy = new float[10];
float[] x = new float[10];
float[] y = new float [10];
float[][] H_2 = {
  {2,-1},
  {-1,1}
};
float[][] H_4 = {
  {4,-6,4,-1},
  {-4.333333,9.5,-7,1.833333},
  {1.5,-4,3.5,-1},
  {-0.166667,0.5,-0.5,0.166667}
};
float[][] H_3 = {
  {3,-3,1},
  {-2.5,4,-1.5},
  {0.5,-1,0.5}
};
float[][] H_5 = {
  {5,-10,10,-5,1},
  {-6.416667,17.833333,-19.5,10.166667,-2.083333},
  {2.958333,-9.833333,12.25,-6.833333,1.458333},
  {-0.583333,2.166667,-3,1.833333,-0.416667},
  {0.041667,-0.166667,0.25,-0.166667,0.041667}
};
float[][] H_6 = {
  {6.000000, -15.000000, 20.000000, -15.000000, 6.000000, -1.000000},
  {-8.700000, 29.250000, -42.333333, 33.000000, -13.500000, 2.283333},
  {4.833333, -19.208333, 31.000000, -25.583333, 10.833333, -1.875000},
  {-1.291667, 5.708333, -10.083333, 8.916667, -3.958333, 0.708333},
  {0.166667, -0.791667, 1.500000, -1.416667, 0.666667, -0.125000},
  {-0.008333, 0.041667, -0.083333, 0.083333, -0.041667, 0.008333}
};
float[][] H_7 = {
  {7.000000, -21.000000, 35.000000, -35.000000, 21.000000, -7.000000, 1.000000},
  {-11.150000, 43.950000, -79.083333, 82.000000, -50.250000, 16.983333, -2.450000},
  {7.088889, -32.741667, 64.833333, -70.694444, 44.666667, -15.408333, 2.255556},
  {-2.312500, 11.833333, -25.395833, 29.333333, -19.270833, 6.833333, -1.020833},
  {0.409722, -2.250000, 5.145833, -6.277778, 4.312500, -1.583333, 0.243056},
  {-0.037500, 0.216667, -0.520833, 0.666667, -0.479167, 0.183333, -0.029167},
  {0.001389, -0.008333, 0.020833, -0.027778, 0.020833, -0.008333, 0.001389}
};
float h=0.005;
int n=2;
void keyPressed(){
  if(keyCode==UP&&mode==0)dy+=25;
  if(keyCode==DOWN&&mode==0)dy-=25;
  if(keyCode==RIGHT&&mode==0)dx-=25;
  if(keyCode==LEFT&&mode==0)dx+=25;
  if(key=='z'){
  N*=sqrt(2.5);
  dx*=sqrt(2.5);
  dy*=sqrt(2.5);
  }
  if(key=='x'&&N>10){
  N/=sqrt(2.5);
  dx/=sqrt(2.5);
  dy/=sqrt(2.5);
  }
  if(key=='o')dx=dy=0;
  if(key=='r')R++;
  if(key=='g')G++;
  if(key=='b')B++;
  if(key=='i'&&mode==0){
  dx=0;
  dy=0;
  mode=1;
  cnt=0;
  }
  if(key==ENTER){
  n=cnt-1;
  convert(cnt);
  mode=0;
  }
  if(key==BACKSPACE&&mode==1&&cnt>0){
  cnt--;
  }
}

void setup(){
  size(500,500);
  background(255);
  smooth(8);
  stroke(204);
  strokeWeight(1);
  grid();
  translate(250,250);
  strokeWeight(2);
  stroke(104);
  line(0,250,0,-250);
  line(-250,0,250,0);
  noStroke();
  fill(200);
  rect(-248,-248,146,46);
}
void caption(int m){
  if(m==0){
  fill(0,190);
  noStroke();
  rect(5,5,170,60);
  fill(255);
  text("Z / X  키를 눌러 확대 / 축소",12,20);
  text("↑ ↓ ← → 키로 상하좌우 이동",12,38);
  text("' I ' 키를 눌러 입력 모드 켜기",12, 56);
  fill(0);
  text("보기 모드",440,20);
  } else {
  fill(0,190);
  noStroke();
  rect(5,5,170,60);
  fill(255);
  text("마우스 클릭으로 점 추가",12,20);
  text("' ← ' 키를 눌러 점 삭제",12,38);
  text("ENTER 키를 눌러 저장",12, 56);
  fill(0);
  text("입력 모드",440,20);
  }
}
void grid(){
  translate(dx,dy);
  strokeWeight(N/25);
  stroke(204);
  for(i=250;i<=100*N;i+=N) {
  line(i,-height/10*N,i,height*2/10*N);
  line(-width/10*N,i,width*2/10*N,i);
  }
  for(i=250;i>=-50*N;i-=N){
  line(i,-height/10*N,i,height*2/10*N);
  line(-width/10*N,i,width*2/10*N,i);
  }
  stroke(104);
  strokeWeight(3*N/50);
  line(250,100*N,250,-50*N);
  line(-50*N,250,100*N,250);
  translate(-dx,-dy);
  stroke(0);
  strokeWeight(1);
  fill(0);
  line(20,475,20,485);
  line(20+N,475,20+N,485);
  line(20,480,20+N,480);
  text(1,20+N/2.0-3,470);
  translate(dx,dy);
}
float x(float t){
  float res=0;
  for(i=0;i<=n;i++)res+=N*cx[i]*pow(t,i);
  return res;
}
float y(float t){
  float res=0;
  for(i=0;i<=n;i++)res+=N*cy[i]*pow(t,i);
  return res;
}
void output(){
  translate(250,250);
  float t;
  int expand = 3;
  stroke(0);
  //stroke(155*(R%2)+100,155*(G%2)+100,155*(B%2)+100);
  strokeWeight(N/40);
  for(t=1-expand;t<n+1+expand;t+=h){
  line(x(t),y(t),x(t+h),y(t+h));
  fill(0);
  }
  fill(0,0,255);
  noStroke();
  for(i=0;i<cnt;i++) {
  ellipse(x[i]*N,y[i]*N,N/5,N/5);
  text(i+1, (x[i]+0.1)*N,y[i]*N);
  }
}
void input(){
  fill(0,0,255,80);
  ellipse(mouseX,mouseY,10,10);
  translate(250+dx,250+dy);
  fill(0,0,255);
  for(i=0;i<cnt;i++){
  ellipse(x[i]*N,y[i]*N,10,10);
  text(i+1, (x[i]+0.1)*N,y[i]*N);
  }
}
void convert(int k){
  for(i=0;i<k;i++){
  cx[i]=cy[i]=0;
  } //initialize
 
  if(k==2){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_2[i][j];
    cy[i]+=y[j]*H_2[i][j];
  }
  }
 
  if(k==3){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_3[i][j];
    cy[i]+=y[j]*H_3[i][j];
  }
  }
 
  if(k==4){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_4[i][j];
    cy[i]+=y[j]*H_4[i][j];
  }
  }
 
  if(k==5){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_5[i][j];
    cy[i]+=y[j]*H_5[i][j];
  }
  }
 
  if(k==6){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_6[i][j];
    cy[i]+=y[j]*H_6[i][j];
  }
  }
 
  if(k==7){
  for(i=0;i<k;i++)for(j=0;j<k;j++){
    cx[i]+=x[j]*H_7[i][j];
    cy[i]+=y[j]*H_7[i][j];
  }
  }
 
  mode=0;
}
void mousePressed(){
  if(mode==1&&cnt<7){
  x[cnt]=map(mouseX,0,500,-250.0/N,250.0/N);
  y[cnt]=map(mouseY,0,500,-250.0/N,250.0/N);
  cnt++;
  }
}
void show_t(){
  stroke(0);
  strokeWeight(1);
  line(245,250,255,250);
  line(250,245,250,255);
}
void show_location(){
  fill(0);
  text("(              ,              )",390,485);
  text(-dx/N,400,485);
  text(dy/N,448,485); 
}
void draw(){
  background(255);
  grid();
  if(mode==0) output();
  else if(mode==1) input();
  translate(-250-dx,-250-dy);
  show_t();
  show_location();
  caption(mode);
}