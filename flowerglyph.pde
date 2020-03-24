void flowerGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
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

    // draw petals
    for (int j = 0; j < values.size(); j++) {
      color c = getColor(colors, j);
      float[] val = values.get(j);
      float line = map(val[i], minValues[i], maxValues[i], 0, lineLength);
      float s = line / 16;
      noStroke();
      strokeWeight(0.75);
      fill(c, 50);
      beginShape();    

      curveVertex(0, 0); // 1
      curveVertex(0, 0); // 2
      curveVertex(line - (s*PI*2.5), - s*PI/2); // 3
      curveVertex(line - (s*PI/2), - s*PI); // 4
      curveVertex(line, 0); // 5

      curveVertex(line - (s*PI/2), s*PI); // 2
      curveVertex(line - (s*PI*2.5), s*PI/2); // 3
      curveVertex(0, 0); // 4

      endShape(CLOSE);
    }

    popMatrix();
  }
}
