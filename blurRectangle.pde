class blurRectangle{
    color c[][];
    int N=3;
    //int kernal[][]={{1,5,1},{5,10,5},{1,5,1}};
    int kernal[][]={{3,1,3},{6,3,6},{3,1,3}};
    //int kernal[][]={{1,1,4,1,1},{1,4,8,4,1},{4,8,16,8,4},{1,4,8,4,1},{1,1,4,1,1}};
    //float kernal[][]={{0.1,0.25,0.5,0.25,0.1},{0.25,0.5,0.85,0.5,0.25},{0.5,0.85,1,0.85,0.5},{0.25,0.5,0.85,0.5,0.25},{0.1,0.25,0.5,0.25,0.1}};
    float kernalSum;
    int kernalLoopVariavle=floor(N/2);
    int x,y,w,h,iterations;

    public blurRectangle(int x,int y,int w, int h,int iterations){
        this.x=x;
        this.y=y;
        this.w=w;
        this.h=h;
        this.iterations=iterations;
        this.c=new color[w+1][h+1];
        
        for(int i=0;i<N;i++){
            for(int j=0;j<N;j++){
                this.kernalSum+=this.kernal[i][j];
            }
        }
        loadPixelsIn();
        calculateBlur();
        storePixelsOut();
    }
    private int mapTo1dArray(int x,int y){
        return y*width+x;
    }

    private void loadPixelsIn(){
        loadPixels();
        for(int i=x;i<=x+w;i++){
            if(i-x<0 || i-x>=width)break;
            for(int j=y;j<=y+h;j++){
                if(j-y<0 || j-y>=height)break;
                c[i-x][j-y]=pixels[mapTo1dArray(i,j)];
            }
        }
    }

    private void calculateBlur(){
        for(int iter=0;iter<iterations;iter++){
            for(int i=0;i<=w;i++){
                for(int j=0;j<=h;j++){
                    float avgR=0;
                    float avgB=0;
                    float avgG=0;
                    for(int p=-kernalLoopVariavle;p<=kernalLoopVariavle;p++){
                        if(p+i<0 || p+i>=w)break;
                        for(int q=-kernalLoopVariavle;q<=kernalLoopVariavle;q++){
                            if(q+j<0 || q+j>=h)break;
                            color temp=c[i+p][j+q];
                            avgR+=kernal[p+kernalLoopVariavle][q+kernalLoopVariavle]*red(temp);
                            avgB+=kernal[p+kernalLoopVariavle][q+kernalLoopVariavle]*blue(temp);
                            avgG+=kernal[p+kernalLoopVariavle][q+kernalLoopVariavle]*green(temp);
                        }
                    }
                    avgR/=kernalSum;
                    avgB/=kernalSum;
                    avgG/=kernalSum;
                    c[i][j]=color(avgR,avgG,avgB);
                }
            }
        }
    }

    private void storePixelsOut(){
        for(int i=x;i<=x+w;i++){
            if(i-x<0 || i-x>=width)break;
            for(int j=y;j<=y+h;j++){
                if(j-y<0 || j-y>=height)break;
                pixels[mapTo1dArray(i,j)]=c[i-x][j-y];
            }
        }
        updatePixels();
    }
}