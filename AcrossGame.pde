int noOfRockets, score, mutex[];
triangleAgent t[];
circleAgent mouse;
boolean gameStopped;
int rectScale;

void setup(){
  size(700,700);
  initializeGame();
  textSize(32);
}

void initializeGame(){
  noOfRockets=3;
  score=0;
  mouse=new circleAgent(new PVector(0,0), 22.5, 25);
  gameStopped=false;
  t=new triangleAgent[noOfRockets];
   mutex=new int[noOfRockets];
  t[0]=new triangleAgent(4,0.3);
  t[1]=new triangleAgent(3,0.18);
  t[2]=new triangleAgent(3.3,0.25);
  // for(int i=0;i<noOfRockets;i++){
  //   float temp=random(2,5);
  //   t[i]=new triangleAgent(temp,map(temp,2,5,0.1,0.8));
  // }
  rectScale=width/2;
}

void draw(){
  if(!gameStopped){
    background(200);
    mouse.setPos(new PVector(mouseX,mouseY));
    triangleAgentEvadeEachOther();
    updateTriangles();
    // triangleAgentEvadeEachOther();
    drawTriangles();
    drawChallengeLines();
    mouse.draw();
    checkRocketCircleCollision();
    if(!gameStopped){
      checkScorelineCircleCollision();
    }
    
    fill(0);
    text(Integer.toString(score),width-50,height-(height-50));
  }
  else{
    displayResults();
  }
}

void drawTriangles(){
  for(triangleAgent i : t){
    i.draw();
  }
}

void updateTriangles(){
  for(triangleAgent i : t){
    i.pursuitCircleAgent(mouse);
  }
}

void drawChallengeLines(){
  for(int i=0;i<noOfRockets;i++){
    int k=(i+1)%noOfRockets;
    line(t[i].pos.x,t[i].pos.y,t[k].pos.x,t[k].pos.y);
  }
}

void checkRocketCircleCollision(){
  for(int i=0;i<noOfRockets;i++){
    for(int j=0;j<3;j++){
      int k=(j+1)%3;
      circleLineIntersection intersection= new circleLineIntersection(t[i].coordinates[j],t[i].coordinates[k],mouse);
      for(int l=0;l<intersection.getNumberOfIntersections();l++){
        drawSidesIntersectedWithCircle(t[i].coordinates[j],t[i].coordinates[k]);
        gameStopped=true;
        //thread("saveGame");
      }
    }
  }
}

void drawSidesIntersectedWithCircle(PVector a, PVector b){
  push();
  stroke(247,135,50);
  strokeWeight(2);
  line(a.x,a.y,b.x,b.y);
  pop();
}

void checkScorelineCircleCollision(){
  int mutexSum=0;
  for(int i=0;i<noOfRockets;i++){
    int k=(i+1)%noOfRockets;
    circleLineIntersection intersection= new circleLineIntersection(t[i].pos,t[k].pos,mouse);
    for(int l=0;l<intersection.getNumberOfIntersections();l++){
      mutex[i]=1;
      drawSidesIntersectedWithCircle(t[i].pos,t[k].pos);
    }
    mutexSum=0;
    for(int j:mutex){mutexSum+=j;}
    if(intersection.getDiscriminant()<0.0){
      if(mutex[i]==1){
        if(mutexSum==1){
          score++;
        }
        mutex[i]=0;
      }
    }
  }
}

void displayResults(){
  background(200);
  drawTriangles();
  drawChallengeLines();
  checkRocketCircleCollision();
  mouse.draw();
  
  push();
  fill(180,90);
  //fill(139,71,255,90);
  noStroke();
  rect(rectScale,rectScale,width-2*rectScale,height-2*rectScale);
  blurRectangle blur=new blurRectangle(rectScale,rectScale,width-2*rectScale,height-2*rectScale,1);
  rectScale-=5+(rectScale/10);
  if(rectScale<=0){
    rectScale=0;
  }
  textAlign(CENTER,CENTER);
  fill(0);
  textSize(map(rectScale,width/2,0,0,32));
  text("GAME OVER",width/2,height/2);
  textSize(map(rectScale,width/2,0,0,20));
  // fill(247,135,50);
  text("SCORE : "+Integer.toString(score),width/2,height/2+35);
  pop();

}

void mouseClicked(){
  if(gameStopped){
    //reinitializing Game
    initializeGame();
  }
}

void triangleAgentEvadeEachOther(){
  for(int i=0;i<noOfRockets;i++){
    t[i].evadeEachOther(t);
  }
  for(int i=0;i<noOfRockets;i++){
    t[i].addTempPos();
  }
}