class circleAgent{
    private PVector pos, prev_pos;
    private float radius, maxVelocity;

    public circleAgent(PVector pos, float radius,float maxVelocity){
        this.pos=pos;
        this.prev_pos=pos;
        this.radius=radius;
        this.maxVelocity=maxVelocity;
    }

    public void setPos(PVector pos){
        this.prev_pos=this.pos;
        PVector p=PVector.sub(pos,this.prev_pos);
        if(p.mag()>maxVelocity){
            p.normalize();
            p.setMag(maxVelocity);
            this.pos=new PVector(p.x+this.prev_pos.x, p.y+this.prev_pos.y);
        }
        else{
            this.pos=pos;
        }
    }
    public void draw(){
        push();
        fill(0,50);
        ellipse(this.pos.x,this.pos.y,this.radius*2,this.radius*2);
        pop();
    }

    public PVector getVelocity(){
        return PVector.sub(this.pos,this.prev_pos);
    }

    public float getPosX(){
        return this.pos.x;
    }

    public float getPosY(){
        return this.pos.y;
    }

    public PVector getPos(){
        return this.pos;
    }
    
    public float getRadius(){
        return this.radius;
    }
}