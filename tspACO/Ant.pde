class Ant{
  int cnt;
  
  IntList path;
  
  //initialize
  Ant(int size){
    cnt = size;
    
    reset();
  }
  
  //reset path
  void reset(){
    path = new IntList();
  }
  
  //update number of possible points
  void update(int val){
    cnt += val;
  }
  
  //check if ant can go to a certain point
  boolean canGo(int i){
    if(i>=cnt) return false;
    
    for(int k=0;k<path.size();k++){
      if(path.get(k)==i) return false;
    }
    
    return true;
  }
  
  //move ant to point
  void go(int i){
    path.append(i);
  }
  
  //check if ant is done traveling
  boolean done(){
    return cnt == path.size();
  }
}
