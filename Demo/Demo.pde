/* GeoBits 

GeoBits is a system for exploring and rendering GeoSpatial data a global scale in a variety of coordinate systems
For more info, visit https://changingplaces.github.io/GeoBits/

This code is the essence of under construction...it's a hot mess

Author: Nina Lutz, nlutz@mit.edu

Supervisor: Ira Winder, jiw@mit.edu

Write date: 8/13/16 
Last Updated: 8/15/16
*/
  boolean lines = false;
  MercatorMap mercatorMap;
  BufferedReader reader;
  String line;
  boolean initialized;

RoadNetwork canvas, selection, handler;
int posx, posy, zoom;

void setup(){
   size(1366, 768, P3D);
   
   initGraphics();
   draw_directions(direction);       
   draw_popup(popup);
   draw_loading(loading);
  
    map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
    
    MapUtils.createDefaultEventDispatcher(this, map);
    smooth();
}

void draw(){
    background(0);
    
    
  if(!pulling){
    map.draw();    
    }
    
 
    if(pull){
      Selection.clear();
      Canvas.clear();
       PullMap(MapTiles(width, height, 0, 0).size(), width, height);
       PullOSM();
       selection.GenerateNetwork(MapTiles(width, height, 0, 0).size());
       canvas.GenerateNetwork(MapTiles(width, height, 0, 0).size());
       draw_popup(popup);
       println("DONE");
       pulling = false;
       pull = false;
    }
     
   
    mercatorMap = new MercatorMap(1366, 768, CanvasBox().get(0).x, CanvasBox().get(1).x, CanvasBox().get(0).y, CanvasBox().get(1).y, 0);
    println(zoom);
    
    if(lines){
    image(Handler, 0, 0);
    }
    
  if(map.getZoomLevel() != zoom){
      if(lines){
      Handler.clear();
      handler.drawRoads(Handler, c);
      image(Handler, 0, 0);
      zoom = map.getZoomLevel();
      }
    }
    
    if(!lines){
      Handler.clear();
    }
    
        
    if(directions){
      image(direction, 0, 0);
    }
    
    if(map.getZoomLevel() >= 14){
       image(popup, 0, 0);
    }
    
        
    if(select && !pulling){
    draw_selection();
    }
    
    
  draw_info();
  
   if(pulling){
      image(loading, 0, 0);
       pull = true;
    }
    
    
}

void mouseDragged(){
  if(lines){
       Handler.clear();
      handler.drawRoads(Handler, c);
      image(Handler, 0, 0);
       left = mercatorMap.getGeo(new PVector(0, 0)).x; 
  }
}
