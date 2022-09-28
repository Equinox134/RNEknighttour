// knight tour Warnsdorffs rule 의 경로를 나타내는 알고리즘

final int WIDTH = 800;
final int HEIGHT = 800;
final int trainNum = 10000;
final int BoardX = 100;
final int BoardY = 100;
final int BLOCKX = HEIGHT / BoardX;
final int BLOCKY = WIDTH / BoardY;
final int X=1,Y=1;
 
boolean start = true;
int value, trueCnt=0, falseCnt=0;
int[][] chessBoard = new int[1001][1001];
int knightX, knightY;
int [] knightWayX = {-2,-2,-1,-1,1,1,2,2};  
int [] knightWayY = {-1,1,-2,2,-2,2,-1,1};

void setup() {
  size(800, 800); 
  for (int i = 0; i < BoardX; i ++) {
    for (int j = 0; j < BoardY; j ++) {
      if ((i + j + 1) % 2 == 0) {
        fill(255, 255, 255); // white
      } else {
        fill(0, 0, 0); // black
      }
      rect(i * BLOCKX, j * BLOCKY, (i + 1) * BLOCKX, (j + 1) * BLOCKY);     
    }
  }
  
  knightX=min(X,HEIGHT/BLOCKX);
  knightY=min(Y,WIDTH/BLOCKY);
  chessBoard[knightX][knightY]=1;
  fill(0,255,0);
  rect(knightX*(BLOCKX),knightY*(BLOCKY),BLOCKX,BLOCKY);
}

int x,y,count,maxCnt,nextX,nextY;
float a;

void draw()
{
  
  if(start){
    
    value=1;
    maxCnt=9;
    nextX=-1; nextY=-1;
    for(int i=0;i<8;i++){
      
      x=knightWayX[i]+knightX;
      y=knightWayY[i]+knightY;
      
      if(x<0 || x>=BoardX || y<0 || y>=BoardY || chessBoard[x][y]==1) continue;
      
      count=0;
      for(int j=0;j<8;j++){
        int xx,yy;
        xx=knightWayX[j]+x;
        yy=knightWayY[j]+y;
        
        if(xx<0 || xx>=BoardX || yy<0 || yy>=BoardY || chessBoard[xx][yy]==1) continue;
        
        count+=1;
      }
      if(count<maxCnt){
        maxCnt=count;
        nextX=x;
        nextY=y;
      }
      else if(count==maxCnt){
          a=random(1000);
          if(a<500){
            nextX=x;
            nextY=y;
          }
      }
    }
    if(nextX==-1 && nextY==-1) start=false;
    else chessBoard[nextX][nextY]=1;
    knightX=nextX;
    knightY=nextY;
    
    
    fill(255, 0, 0);
    rect(knightX*(BLOCKX),knightY*(BLOCKY),BLOCKX,BLOCKY);
  }
}
