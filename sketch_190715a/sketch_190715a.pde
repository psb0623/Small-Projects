PImage img;
PImage thk,win,winn,lose;
int[] a = new int[13];
int[] effect = new int[13];
int[] eff = new int[13];
int c = 0;
int cx = 0;
int dly = 0;
int w = 0;
boolean humanturn = true;
void setup(){
  textAlign(CENTER,CENTER);
  textSize(20);
  smooth();
  size(800,800);
  img = loadImage("ai.png");
  thk = loadImage("think.jpg");
  win = loadImage("win.jpg");
  winn = loadImage("winn.PNG");
  lose = loadImage("lose.jpg");
  for(int i=0;i<13;i++) a[i] = (int)floor(random(0,1.999));
  a[12] = 1;
  for(int i=0;i<13;i++) eff[i] = effect[i] = 0;
}
void draw(){
  background(0,120,100);
  if(w==0){
    stone();
    render();
  } else win();
}
void mousePressed(){
  if(humanturn&&effect[12]==0){
    for(int i=0;i<13;i++){
      if(dist(mouseX,mouseY,100+50*i,700)<=30&&a[i]==1){
        flip(i);
        humanturn = false;
      }
    }
  }
}
void render(){
  for(int i=0;i<13;i++){
    if(effect[i]>0){
      effect[i]--;
      if(effect[i]==0){
        if(a[i]==1) a[i]=0;
        else a[i]=1;
      }
    }
  }
  for(int i=0;i<13;i++){
    if(eff[i]>0){
      if(eff[i]<10){
        noFill();
        strokeWeight(4);
        stroke(255,eff[i]*20);
        ellipse(100+i*50,700,10*(10-eff[i]),10*(10-eff[i]));
      }
      eff[i]--;
    }
  }
  if(c>0){
    fill(255,0,0);
    triangle(100+50*cx,700-23,100+50*cx-10,700-40,100+50*cx+10,700-40);
    c--;
  }
  fill(255,0,0);
  textSize(20);
  text("AI turn",400,50);
  text(str(random(0,100))+"%",500,50);
  stone();
  if(effect[12]==0&&humanturn==false&&dly==0) dly = 80;
  if(dly>0){
    think();
    dly--;
    if(dly==0) {
      int sum = 0;
      for(int i=0;i<13;i++) sum += a[i];
      if(sum!=0) ai();
      if(sum==0) w = 1;
    }
  } else nomal();
}
void nomal(){
  if(random(0,1)<0.1) image(img,0,0,800,600);
  else image(lose,0,0,800,600);
  fill(0,0,255);
  textSize(64);
  text("Human turn",400,50);
}
void think(){
  image(thk,0,0,800,600);
  fill(255,0,0);
  textSize(64);
  text("AI turn",400,50);
  textSize(80);
  text("computing...",400,400);
  textSize(40);
  text("Winning Rate : "+str(random(0,100))+"%",400,300);
}
void win(){
  image(win,0,0,800,600);
  fill(255,0,0);
  textSize(64);
  text("You win",400,50);
  image(winn,0,600,800,200);
}
void stone(){
  for(int i=0;i<13;i++){
    stroke(0);
    strokeWeight(1);
    if(a[i]==1) fill(0);
    else fill(210);
    ellipse(100+50*i,703,30,30);
    
    if(a[i]==1) fill(20);
    else fill(250);
    ellipse(100+50*i,700,30,30);
    
    if(dist(mouseX,mouseY,100+50*i,700)<=25&&a[i]==1){
      noStroke();
      fill(0,0,255);
      if(humanturn) triangle(100+50*i,723,100+50*i-10,740,100+50*i+10,740);
    }
  }
}
void ai(){
  while(true){
    stone();
    int x = floor(random(0,12.99));
    float ok = random(0,1);
    if(a[x]==1){
      cx=x;
      c=3*(13-x);
      flip(x);
      humanturn = true;
      break;
    }
  }
}
void flip(int x){
  for(int i=x;i<13;i++){
    eff[i] = effect[i] = 5*(i-x+1);
  }
}
