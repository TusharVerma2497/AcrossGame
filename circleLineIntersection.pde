class circleLineIntersection{
    private double a, b, c, d, m;
    private ArrayList<Double> roots=new ArrayList();
    private int numberOfIntersections;

    public circleLineIntersection(PVector p1, PVector p2, circleAgent mouse){
        if(p2.x-p1.x==0)
            this.m=(p2.y-p1.y)/0.000000001;
        else
            this.m=(p2.y-p1.y)/(p2.x-p1.x);
        double c1=(p1.y-this.m*p1.x);
        this.a=this.m*this.m+1;
        this.b=2*(this.m*(c1-mouse.getPosY())-mouse.getPosX());
        this.c=Math.pow(mouse.getPosX(),2)+Math.pow((c1-mouse.getPosY()),2)-pow(mouse.getRadius(),2);
        this.d=this.b*this.b-4*this.a*this.c;

        if(this.d>0.0){
            double t= (-this.b+Math.sqrt(this.d))/(2*this.a);
            if(isWithinXRange(t,p1.x,p2.x)){
                this.roots.add(t);
            }
            t= (-this.b-Math.sqrt(this.d))/(2*this.a);
            if(isWithinXRange(t,p1.x,p2.x)){
                this.roots.add(t);
            }
            
        }
        this.numberOfIntersections=this.roots.size();
        
    }

    private Boolean isWithinXRange(double tempx,float x1,float x2){
        if(tempx>=x1 &&tempx<=x2 || tempx<=x1 && tempx>=x2){
            return true;
        }
        return false;
    }

    public int getNumberOfIntersections(){
        return this.numberOfIntersections;
    }

    public ArrayList<Double> getRoots(){
        return this.roots;
    }

    public double getDiscriminant(){
        return this.d;
    }
}