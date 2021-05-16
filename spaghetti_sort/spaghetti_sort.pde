int[] a = new int[100];
int[] b = new int[100];
boolean[] chk = new boolean[100];
int c=0;
void setup(){
  size(1000,500);
  for(int i=0;i<100;i++){
    a[i] = round(random(1,100));
  }
}
void bar(){
    stroke(0);
  strokeWeight(1);
  for(int i=0;i<100;i++){
    if(chk[i]) fill(0,255,0);
    else fill(255);
    
    rect(5*i,500-5*a[i],5,5*a[i]);
  }
}

void srt(){
    stroke(0);
  strokeWeight(1);
  for(int i=0;i<100;i++){
    fill(255);
    rect(5*i+500,500-5*b[i],5,5*b[i]);
  }
}

void hand(int h){
  stroke(255,0,0);
  strokeWeight(2);
  line(0,500-h*5,500,500-h*5);
  for(int i=0;i<100;i++){
    if(a[i]==h){
      chk[i] = true;
    }
    if(a[i] == h+1){
      b[c++] = a[i];
      chk[i] = false;
      a[i] = -1;
    }
  }
}

int k=100;
void draw(){
  background(204);
  hand(k);
  bar();
  srt();

  stroke(0);
  strokeWeight(2);
  line(500,500,500,0);
  
  delay(100);
  if(k>=0) k--;
}