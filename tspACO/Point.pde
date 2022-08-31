class Point{
  float x,y;
  
  //initialize
  Point(float x1, float y1){
    x = x1;
    y = y1;
  }
  
  //get distance between two points
  float distance(Point p){
    return sqrt((x-p.x)*(x-p.x)+(y-p.y)*(y-p.y));
  }
}
