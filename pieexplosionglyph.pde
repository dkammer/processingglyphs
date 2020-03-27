void pieexplosionGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);
  color[] colors = { c };
  pieexplosionGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void pieexplosionGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;
  float angle = 360 / numDimensions;

  for (int i = 0; i < numDimensions; i++) {
    pushMatrix(); 
    translate(originX, originY);
    rotate(radians(360/numDimensions*i)-radians(90));
   
    // draw axes
    if (drawAxes) {
      drawAxis(lineLength);
    }

    // draw slices
    for (int j = 0; j < values.size(); j++) {
      color c = getColor(colors, j);
      float[] val = values.get(j);      
      float line = map(val[i], minValues[i], maxValues[i], 0, lineLength * 2);

      noStroke();
      fill(scaleColor(line, lineLength * 2, c), Math.max(45, 255 - j * 30));
      arc(0, 0, line, line, radians(-angle/2), radians(angle/2));
    }
    popMatrix();
  }    
} 