class AntColonyOpt{
  Graph graph;
  int antNum,cnt;
  float alpha, beta, Q, evaCo;
  
  float minlength=10000000;
  
  ArrayList<Ant> ants;
  ArrayList<FloatList> chance;
  IntList startLoc,shortPath;
  
  //initialize
  AntColonyOpt(Graph gr, int num, float a1, float b1, float q, float ec){
    graph = gr;
    antNum = num;
    alpha = a1;
    beta = b1;
    Q = q;
    evaCo = ec;
    
    cnt = gr.cnt;
    reset();
    updateChance();
  }
  
  AntColonyOpt(Graph gr, int num){
    graph = gr;
    antNum = num;
    alpha = random(0,10);
    beta = random(1,10);
    Q = random(10,100000);
    evaCo = random(0,1);
    //print(alpha + " " + beta + " " + Q + " " + evaCo + "\n\n");
    
    cnt = gr.cnt;
    reset();
    updateChance();
  }
  
  //reset
  void reset(){
    startLoc = new IntList();
    ants = new ArrayList<Ant>();
    for(int i=0;i<antNum;i++){
      ants.add(new Ant(cnt));
      startLoc.append(int(random(0,cnt)));
    }
  }
  
  void iterateAnt(int idx){
    int curloc = startLoc.get(idx);
    while(!ants.get(idx).done()){
      int ne = getE(curloc,idx);
      ants.get(idx).go(ne);
      curloc = ne;
    }
  }
  
  void iterate(){
    for(int i=0;i<antNum;i++) iterateAnt(i);
    
    for(int i=0;i<cnt;i++){
      for(int j=i+1;j<cnt;j++){
        graph.changePh(i,j,-evaCo*graph.getPh(i,j));
      }
    }
    
    for(int i=0;i<antNum;i++){
      Ant ant = ants.get(i);
      float totd=0;
      for(int j=0;j<cnt;j++){
        int nj = (j+1)%cnt;
        totd += graph.length(ant.path.get(j),ant.path.get(nj));
      }
      //if(totd==0) print(ant.path+" "+i+" "+startLoc.get(i)+"\n");
      if(totd<minlength){
        shortPath = ant.path;
        minlength = totd;
      }
      for(int j=0;j<cnt;j++){
        int nj = (j+1)%cnt;
        graph.changePh(ant.path.get(j),ant.path.get(nj),Q/totd);
      }
    }
    reset();
    updateChance();
  }
  
  void drawPh(float ox, float oy){
    background(255,255,255);
    for(int i=0;i<cnt;i++){
      for(int j=i+1;j<cnt;j++){
        float ph = graph.getPh(i,j);
        float x1 = graph.vertex.get(i).x+ox, x2 = graph.vertex.get(j).x+ox;
        float y1 = graph.vertex.get(i).y+oy, y2 = graph.vertex.get(j).y+oy;
        //print(ph+"\n");
        //print(constrain(ph,10,255)+"\n");
        strokeWeight(6);
        stroke(0,255,0,constrain(ph,0.05,2)*127);
        line(x1,y1,x2,y2);
      }
    }
    //print("\n");
  }
  
  void drawSh(float ox, float oy){
    for(int i=0;i<cnt;i++){
      int j = (i+1)%cnt;
      float x1 = graph.vertex.get(shortPath.get(i)).x, x2 = graph.vertex.get(shortPath.get(j)).x;
      float y1 = graph.vertex.get(shortPath.get(i)).y, y2 = graph.vertex.get(shortPath.get(j)).y;
      strokeWeight(6);
      stroke(0,0,0,255);
      line(x1+ox,y1+oy,x2+ox,y2+oy);
    }
  }
  
  int getE(int x, int idx){
    float sum=0;
    IntList can = new IntList();
    FloatList p = new FloatList();
    for(int i=0;i<cnt;i++){
      if(i==x) continue;
      if(ants.get(idx).canGo(i)){
        sum += getChance(x,i);
        //print(getChance(x,i)+"\n");
        can.append(i);
      }
    }
    //print(idx + "\n");
    float sow=0;
    for(int i=0;i<can.size();i++){
      float po = getChance(x,can.get(i))/sum;
      sow += po;
      p.append(po);
    }
    //print(sum+"\n");
    float rnd = random(sow);
    for(int i=0;i<can.size();i++){
      if(rnd<p.get(i)) return can.get(i);
      //print(rnd+"\n");
      rnd -= p.get(i);
    }
    //print(sum+"\n");
    if(sum == 0) return can.get(0);
    //print(rnd+"\n");
    //print("asdasdasd\n");
    return 0;
  }
  
  void updateChance(){
    chance = new ArrayList<FloatList>();
    for(int i=0;i<cnt;i++){
      FloatList tmp = new FloatList();
      for(int j=0;j<cnt;j++){
        tmp.append(calcChance(i,j));
      }
      chance.add(tmp);
    }
  }
  
  float calcChance(int i, int j){
    float dist = graph.length(i,j);
    float pher = graph.getPh(i,j);
    float top = pow(pher,alpha)*pow(1/dist,beta);
    //print(top + "\n");
    return top;
  }
  
  float getChance(int i, int j){
    if(i>=cnt||j>=cnt){
      //print(cnt+" "+i+" "+j+"wtf\n");
      return 0;
    }
    FloatList tmp = chance.get(i);
    return tmp.get(j)*9999999;
  }
}
