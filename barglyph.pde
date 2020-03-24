void barGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);
  color[] colors = { c };
  barGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void barGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;
  float barWidth = lineLength * 2 / numDimensions; 
  float startX = originX - lineLength;
  float startY = originY + lineLength;

  for (int i = 0; i < numDimensions; i++) {
    float x = startX + i * barWidth;
    
    // draw unfilled rectangles
    if (drawAxes) {
      noFill();
      stroke(50, 50, 50);
      strokeWeight(0.5);
      rect(x, startY - lineLength * 2, barWidth, lineLength * 2);
    }
      
    // draw bars
    for (int j = 0; j < values.size(); j++) {
      color c = getColor(colors, j);
      float[] val = values.get(j);
      
      float line = map(val[i], minValues[i], maxValues[i], 0, lineLength * 2);
      noStroke();
      strokeWeight(0.75);
      fill(c, 200);      
      rect(x, startY - line, barWidth, line); 
    }
  }
}
