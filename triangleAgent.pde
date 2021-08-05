class triangleAgent{
  private PVector pos, acceleration, velocity, coordinates[];
  private float stearingConstant, maxVelocity;
  private PVector tempPos;
  
  public triangleAgent(float MaxVelocity,float StearingConstant){
    this.maxVelocity=MaxVelocity;
    this.stearingConstant=StearingConstant;
    this.pos=new PVector(int(random(450,500)),int(random(450,500)));
    //this.pos=new PVector(500,500);
    this.velocity=new PVector(0,0);
    this.coordinates=new PVector[3];
  }
  public void pursuitCircleAgent(circleAgent mouse){
    PVector p=mouse.getPos().copy();
    PVector mouseVel=mouse.getVelocity().copy();
    mouseVel.normalize();
    mouseVel.setMag(55);
    p.add(mouseVel); // now p signifies predicted value of mouse position 
    //ellipse(p.x,p.y,8,8);
    this.acceleration=PVector.sub(p,this.pos);
    this.acceleration.normalize();
    this.acceleration.setMag(this.stearingConstant);
    this.velocity.add(this.acceleration);
    //this.velocity.mult(10);
    
    //Checking speed constrain
    if(velocity.mag()>maxVelocity){
      velocity.normalize();
      velocity.setMag(maxVelocity);
    }
    this.pos.add(this.velocity);
    setCoordinates();
    
  }

  public void evadeEachOther(triangleAgent[] arr){
    this.tempPos=new PVector(0,0);
    for(int i=0; i<arr.length && !this.equals(arr[i]); i++){
      PVector p=PVector.sub(this.pos,t[i].pos);
      if(p.mag()<=50){
      float mag=map(p.mag(),5,50,10,0);
      p.normalize();
      p.setMag(mag);
      this.tempPos.add(p);
      }
    }
  }

public void addTempPos(){
  if(this.tempPos.mag()>maxVelocity){
      this.tempPos.normalize();
      this.tempPos.setMag(maxVelocity);
    }
  this.pos.add(this.tempPos);
}

  private void setCoordinates(){
      //these coordinates are with respect to pos.x and pos.y
    this.coordinates[0]=new PVector(20,0);
    this.coordinates[1]=new PVector(-30,-10);
    this.coordinates[2]=new PVector(-30,10);
  
  
    //rotating body of the triangle with the calculated angle
    float angle=atan2(velocity.y,velocity.x);
    for(int i=0;i<3;i++){
      this.coordinates[i].rotate(angle);
      this.coordinates[i].x+=this.pos.x;
      this.coordinates[i].y+=this.pos.y;
    }
  }

  public void draw(){
    //Drawing the triangle with coordinates
    push();
    fill(100);
    stroke(2);
    triangle(this.coordinates[0].x,this.coordinates[0].y,this.coordinates[1].x,this.coordinates[1].y,this.coordinates[2].x,this.coordinates[2].y);
    pop();
  }
}
