ArrayList<Point> points = new ArrayList<Point>();
Graph graph;
AntColonyOpt aco;

boolean ac = false;
int iter=0, imax=10000;

void setup(){
  size(2000,1000);
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
  }
  stroke(0,0,0,255);
  strokeWeight(6);
  line(1000,0,1000,1000);
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
    ac = !ac;
    graph = new Graph(points);
    aco = new AntColonyOpt(graph,20,1,4,20,0.3);
  }
}
