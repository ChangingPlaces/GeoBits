Horde Ped_Old, Ped_Middle, Ped_Family;

void initPop(PGraphics p) {

  println("Initializing Pedestrian Objects ... ");
  
  Ped_Old = new Horde(1000);
  Ped_Middle = new Horde(1000);
  Ped_Family = new Horde(1000);
  
  sources_Viz = createGraphics(p.width, p.height);
  testNetwork_Pop(p, 6);
  
  swarmPaths(p, enablePathfinding);
  sources_Viz(p);
  
  println("Pedestrians initialized.");
}


void testNetwork_Pop(PGraphics p, int _numNodes) {
  PVector location = new PVector(random(mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(1)).x, mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(2)).x), 
        random(mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(2)).y,  mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(0)).y));
  
  int numNodes, numEdges, numSwarm;
  
  numNodes = _numNodes;
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();
  
  if(surge){
  swarmHorde2.clearHorde();
  }
  
  for (int i=0; i<numNodes; i++) {
    int a = int(random(0, places.POIs.size()));
    PVector loc = mercatorMap.getScreenLocation(places.POIs.get(a).location);
    nodes[i] =  loc;
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(0.1, 2.0);
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    // delay, origin, destination, speed, color
    if(origin[i] != destination[i]){
      swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, #00ff00);
    if(surge){
      swarmHorde2.addSwarm(.1, location, destination[i], 1, #ff0000);
      }
    }
    
    // Makes sure that Pedestrians 'staying put' eventually die
    swarmHorde.getSwarm(i).temperStandingPedestrians();
    swarmHorde2.getSwarm(i).temperStandingPedestrians();
  }
  colorMode(RGB);
  
  swarmHorde.popScaler(1.0);
  swarmHorde2.popScaler(1.0);
}
