void ringGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);
  color[] colors = { c };
  ringGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void ringGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;
  float ringWidth = lineLength * 2 / (numDimensions + 1);

  strokeWeight(ringWidth/2 - ringWidth/6);
  strokeCap(SQUARE);
  noFill();

  for (int i = 0; i < numDimensions; i++) {
    float r = ringWidth + i * ringWidth;

    pushMatrix();
    translate(originX, originY);
    rotate(-radians(90));

    // draw axes rings
    if (drawAxes) {
      stroke(220,220,220);
      arc(0, 0, r, r, 0, radians(360));
    }

    // draw slices
    for (int j = 0; j < values.size(); j++) {
      color c = getColor(colors, j);
      float[] val = values.get(j);
      float angle = map(val[i], minValues[i], maxValues[i], 0, 360);
      stroke(scaleColor(angle, 360, c), Math.max(45, 255 - j * 30));
      arc(0, 0, r, r, 0, radians(angle));      
    }
    popMatrix();
  }    
} 