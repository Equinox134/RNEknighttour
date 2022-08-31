class Graph{
  ArrayList<Point> vertex;
  
  int cnt;
  ArrayList<FloatList> edge;
  ArrayList<FloatList> pheromone;
  
  //initialize
  Graph(){
    vertex = new ArrayList<Point>();
    
    reset();
  }
  
  Graph(ArrayList<Point> points){
    vertex = points;
    
    reset();
  }
  
  //reset
  void reset(){
    resetEdge();
    resetPh();
  }
  
  void resetEdge(){
    cnt = vertex.size();
    edge = new ArrayList<FloatList>();
    
    for(int i=0;i<cnt;i++){
      FloatList tmp = new FloatList();
      for(int j=0;j<cnt;j++){
        Point p = vertex.get(i);
        float k = p.distance(vertex.get(j));
        tmp.append(k);
      }
      edge.add(tmp);
    }
  }
  
  void resetPh(){
    cnt = vertex.size();
    pheromone = new ArrayList<FloatList>();
    
    for(int i=0;i<cnt;i++){
      FloatList tmp2 = new FloatList();
      for(int j=0;j<cnt;j++){
        tmp2.append(1);
      }
      pheromone.add(tmp2);
    }
  }
  
  //add point to graph
  void add(Point x){
    vertex.add(x);
    resetEdge();
    newPh();
  }
  
  //get length of an edge
  float length(int i, int j){
    if(i>=cnt||j>=cnt) return 1000000;
    FloatList tmp = edge.get(i);
    return tmp.get(j);
  }
  
  //get the distance of a certain path
  float pathDist(IntList path){
    if(path.size()!=cnt) return 1000000;
    float d=0;
    for(int i=0;i<cnt;i++){
      int j = (i+1)%cnt;
      int ii = path.get(i), jj = path.get(j);
      d += vertex.get(ii).distance(vertex.get(jj));
    }
    return d;
  }
  
  //get the pheromone amount of an edge
  float getPh(int i, int j){
    if(i>=cnt||j>=cnt) return 1000000;
    FloatList tmp = pheromone.get(i);
    return tmp.get(j);
  }
  
  //change the pheromone amount of an edge
  void changePh(int i, int j, float val){
    if(i>=cnt||j>=cnt) return;
    FloatList ph1 = pheromone.get(i), ph2 = pheromone.get(j);
    ph1.set(j,ph1.get(j)+val);
    pheromone.add(i,ph1); pheromone.remove(i+1);
    ph2.set(i,ph2.get(i)+val);
    pheromone.add(j,ph2); pheromone.remove(j+1);
  }
  
  //change the pheromone amount when new point added
  void newPh(){
    for(int i=0;i<cnt-1;i++){
      FloatList t = pheromone.get(i);
      t.append(1);
      pheromone.add(i,t); pheromone.remove(i+1);
    }
    FloatList tmp = new FloatList();
    for(int i=0;i<cnt;i++){
      tmp.append(1);
    }
    pheromone.add(tmp);
  }
}
