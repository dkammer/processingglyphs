void flowerGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);  
  color colors[] = { c };
  flowerGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void flowerGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;

  for (int i = 0; i < numDimensions; i++) {
    pushMatrix(); 
    translate(originX, originY);
    rotate(radians(360/numDimensions*i)-radians(90));

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
      fill(scaleColor(line, lineLength, c));
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
