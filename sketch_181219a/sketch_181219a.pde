int N=10000000;

float Rmax = 14;

String[] name = {"1s","2s","2px","2py","2pz","3s","3px","3py","3pz"};

float[][] R = new float[10][100000];
float[][] T = new float[10][100000];
float[][] P = new float[10][100000];

int[] num = new int[10];

int now = 0;

int[][] button = new int[9][4];

float rad = 0.75;
float d = 10;
float dd = 0;
float dx = 0;
float dr = 0;
 
float r(float x, float y, float z){return sqrt(x*x+y*y+z*z);}
float theta(float x,float y){if(y>0) return acos(x/sqrt(x*x+y*y)); else return -acos(x/sqrt(x*x+y*y));}
float phi(float x, float y, float z){return atan(z/sqrt(x*x+y*y));}
float x(float r, float theta, float phi){return map(r*cos(phi)*cos(theta)+dr,-tan(rad)*(r*cos(phi)*sin(theta)+d+dd),tan(rad)*(r*cos(phi)*sin(theta)+d+dd),0,width);}
float y(float r, float theta, float phi){return map(r*sin(phi),-tan(rad)*(r*cos(phi)*sin(theta)+d+dd),tan(rad)*(r*cos(phi)*sin(theta)+d+dd),height,0);}

void setup(){
  int w = width/10;
  int offset = width/80;
  
  for(int i=0;i<9;i++){
    button[i][0] = i*w + offset;
    button[i][1] = height - w + offset;
    button[i][2] = (i+1) * w - offset;
    button[i][3] = height - offset;
  }
  
  size(768,768);
  smooth();
  
  data();
}

void data(){
  int cnt=0;
  
  while(cnt<N){
    float r = sqrt(random(0,Rmax*Rmax));
    float p = random(-PI/2, PI/2);
    float t = random(0,2*PI);
    
    float[] k = new float[10];
    k[0] = sqrt(1/PI) * exp(-r);
    k[1] = 1.0/8 * sqrt(2/PI) * (2-r) * exp(-r/2);
    k[2] = 1.0/8 * sqrt(2/PI) * r * exp(-r/2) * cos(PI/2-p);
    k[3] = 1.0/8 * sqrt(2/PI) * r * exp(-r/2) * sin(PI/2-p) * cos(t);
    k[4] = 1.0/8 * sqrt(2/PI) * r * exp(-r/2) * sin(PI/2-p) * sin(t);
    k[5] = 1.0/81 * sqrt(1/(3*PI)) * (27-18*r+2*r*r) * exp(-r/3);
    k[6] = 1.0/81 * sqrt(2/PI) * r * (6-r) * exp(-r/3) * cos(PI/2-p);
    k[7] = 1.0/81 * sqrt(2/PI) * r * (6-r) * exp(-r/3) * sin(PI/2-p) * cos(t);
    k[8] = 1.0/81 * sqrt(2/PI) * r * (6-r) * exp(-r/3) * sin(PI/2-p) * sin(t);
    for(int i=0;i<9;i++){
      if(random(0,1)<=k[i]*k[i]) {
        R[i][num[i]] = r;
        T[i][num[i]] = t;
        P[i][num[i]] = p;
        num[i]++;
      }
    }
    
    cnt++;
  }
}

void RenderButton(){
  stroke(0,104,0);
  fill(0,255,0);
  for(int i=0;i<9;i++){
    if(now==i) fill(0,150,0);
    else fill(0,255,0);
    rect(button[i][0],button[i][1], button[i][2] - button[i][0],button[i][3] - button[i][1] );
  }
  fill(0);
  textSize(20);
  for(int i=0;i<9;i++) text(name[i],(button[i][0]+button[i][2])/2,(button[i][1]+button[i][3])/2);
}

void RenderData(){
  noStroke();
  fill(255);
  for(int i=0;i<num[now];i++){
    if(R[now][i]<d+dd) ellipse(x(R[now][i],T[now][i]+dx,P[now][i]),y(R[now][i],T[now][i]+dx,P[now][i]),3,3);
  }
}

void Bohr(){
  strokeWeight(2);
  
  stroke(255,0,0);
  fill(255,0,0);
  
  ellipse(x(0,0,0),y(0,0,0),4,4);
  
  line(x(0,0,0),y(0,0,0),x(1,0,0),y(1,0,0));
  
  textAlign(CENTER,CENTER);
  
  textSize(16);
  text("a0", x(0.5,0,0), y(0.5/cos(PI/8),0,-PI/8));
}

void draw(){
  
  background(0);
  strokeWeight(3);
  d=10*(1/tan(rad));

  if(keyPressed&&key=='w')dd=dd-0.3;
  if(keyPressed&&key=='s')dd=dd+0.3;
  if(keyPressed&&key=='a')dr=dr+0.1;
  if(keyPressed&&key=='d')dr=dr-0.1;
  
  RenderData();
  
  Bohr();
  
  RenderButton();
  
  dx+=0.01;
}

void mousePressed(){
  for(int i=0;i<9;i++) {
    if(button[i][0]<mouseX&&button[i][1]<mouseY&&button[i][2]>mouseX&&button[i][3]>mouseY) now=i;
  }
}

void keyPressed(){
  if(key=='w')dd=dd-0.3;
  if(key=='s')dd=dd+0.3;
  if(key=='a')dr=dr+0.1;
  if(key=='d')dr=dr-0.1;
}
