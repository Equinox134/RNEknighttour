// Warnsdorffs rule 의 성공 확률을 측정하는 프로그램
// 성공 횟수, 실패 횟수, 확률을 출력

final int WIDTH = 800;
final int HEIGHT = 800;
final int trainNum = 100000; // 실행 횟수
final int BoardX = 120; // 보드 행 크기
final int BoardY = 120; // 보드 열 크기
final int BLOCKX = HEIGHT / BoardX;
final int BLOCKY = WIDTH / BoardY;
 
boolean start = true;
int value, trueCnt=0, falseCnt=0, mWayNum;
int[][] chessBoard = new int[1001][1001];
int knightX, knightY;
int [] knightWayX = {-2,-2,-1,-1,1,1,2,2};
int [] knightWayY = {-1,1,-2,2,-2,2,-1,1};
int [] minWay = new int[9];

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
  
  for(int p=0;p<trainNum;p++){
    if(p%(trainNum/10)==0) print("count = " + p + "\n");
    knightX=((int)random(HEIGHT)/BLOCKX);
    knightY=((int)random(WIDTH)/BLOCKY);
    chessBoard[knightX][knightY]=1;
    //fill(0,255,0);
    //rect(knightX*(BLOCKX),knightY*(BLOCKY),BLOCKX,BLOCKY);
    start=true;
    for(int i=1;i<BoardX*BoardY;i++){
      draw(i);
      if(!start) break;
    }
    if(start){
        trueCnt++;
        //print("True" + "\n");
      } 
    else{
        falseCnt++;
        //print("False" + "\n");
    }
    for(int i=0;i<BoardX;i++){
      for(int j=0;j<BoardY;j++){
        chessBoard[i][j]=0;
      }
    }
  }
  print(trueCnt + " " + falseCnt + "\n");
  print((float)trueCnt*(float)100/(float)trainNum + "%");
}

int x,y,count,maxCnt,nextX,nextY;
float a;

void draw(int testNum)
{
  if(start){
    
    value=1;
    maxCnt=9; mWayNum=0;
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
        mWayNum=1;
        minWay[mWayNum]=i;
        maxCnt=count;
      }
      else if(count==maxCnt){
          mWayNum++;
          minWay[mWayNum]=i;
      }
    }
    if(mWayNum==0){
      start=false;
    }
    else{
      a=random(mWayNum);
      nextX=knightX+knightWayX[minWay[(int)a+1]];
      nextY=knightY+knightWayY[minWay[(int)a+1]];
      chessBoard[nextX][nextY]=1;
      knightX=nextX; 
      knightY=nextY;
    }
    
    //fill(255, 0, 0);
    //rect(knightX*(BLOCKX),knightY*(BLOCKY),BLOCKX,BLOCKY);
  }
  
}
