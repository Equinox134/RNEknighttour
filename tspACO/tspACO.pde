ArrayList<Point> points = new ArrayList<Point>();
Graph graph;
AntColonyOpt aco;

boolean ac = false;
int iter=0, imax=10000, numAnt=0;
float minl=1000000;
int antNum=20;
float phW=1, dW=4, phS=30, ec=0.3;

void setup(){
  size(2000,1100);
  background(255,255,255);
}

void draw(){
  clear();
  background(255,255,255);
  fill(0,0,0);
  //print(ac+"\n");
  drawP();
  if(ac){
    aco.iterate();
    aco.drawPh(0,0);
    aco.drawSh(1000,0);
    iter++;
    numAnt += 20;
    minl = min(minl,aco.minlength);
  }
  stroke(0,0,0,255);
  strokeWeight(6);
  line(1000,0,1000,1200);
  fill(0);
  textSize(70);
  text("Pheromone Map",20,70);
  text("Current Shortest Path",1020,70);
  textSize(50);
  text("# of Ants: " + numAnt,20,130);
  text("# of Iterations: " + iter,20,180);
  text("Current Minimum Distance: " + minl,1020,130);
  textSize(30);
  text("phW: "+phW,20,1080);
  text("distW: "+dW,170,1080);
  text("phS: "+phS,320,1080);
  text("ec: "+ec,470,1080);
  //if(iter>=imax&&ac) ac = !ac;
  //delay(100);
}

void drawP(){
  fill(0,0,0);
  for(int i=0;i<points.size();i++){
    ellipse(points.get(i).x,points.get(i).y,10,10);
  }
}

void mousePressed(){
  float x = mouseX, y = mouseY;
  if(x>=999) return;
  Point p = new Point(x,y);
  points.add(p);
}

void keyPressed(){
  if(keyCode == ENTER){
    numAnt=0;
    iter=0;
    ac = !ac;
    graph = new Graph(points);
    aco = new AntColonyOpt(graph,antNum,phW,dW,phS,ec);
  }
}
