void starGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numTasks = maxValues.length;
  List<List<PVector>> polygons = new ArrayList<List<PVector>>();

  for (int i = 0; i < numTasks; i++) {
    pushMatrix(); 
    translate(originX, originY);
    rotate(radians(360/numTasks*i)-radians(90));

    // draw axes
    if (drawAxes) {
      drawAxis(lineLength);
    }

    // build polygon from vectors of each value
    for (int j = 0; j < values.size(); j++) {
      List<PVector> polygon;
      if (polygons.size() <= j) {
        polygon = new ArrayList<PVector>();
        polygons.add(polygon);
      }
      polygon = polygons.get(j);
      float[] val = values.get(j);
      float line = map(val[i], minValues[i], maxValues[i], 0, lineLength);  
      float x = screenX(line, 0);
      float y = screenY(line, 0);
      polygon.add(new PVector(x, y));
    }
    popMatrix();
  }

  // print polygons
  for (int i = 0; i < polygons.size(); i++) {
    color c = getColor(colors, i);
    List<PVector> polygon = polygons.get(i);
    noStroke();
    strokeWeight(0.75);
    fill(c, 50);
    beginShape();    
    for (int j = 0; j < polygon.size(); j++) {
      vertex(polygon.get(j).x, polygon.get(j).y);
    }
    endShape(CLOSE);
    stroke(c);
    for (int j = 0; j < polygon.size() - 1; j++) {
      line(polygon.get(j).x, polygon.get(j).y, polygon.get(j+1).x, polygon.get(j+1).y);
    }
    line(polygon.get(0).x, polygon.get(0).y, polygon.get(polygon.size()-1).x, polygon.get(polygon.size()-1).y);
  }
} 
