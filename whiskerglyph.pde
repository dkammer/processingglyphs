void whiskerGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);
  color[] colors = { c };
  whiskerGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void whiskerGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;
  for (int i = 0; i < numDimensions; i++) {
    pushMatrix(); 
    translate(originX, originY);
    rotate(radians(360/numDimensions*i)-radians(90));

    // draw axes
    if (drawAxes) {
        drawAxis(lineLength);
    }

    // draw lines
    for (int j = 0; j < values.size(); j++) {
      color c = getColor(colors, j);
      float[] val = values.get(j);
      float line = map(val[i], minValues[i], maxValues[i], 0, lineLength);
      strokeWeight(lineLength/10);
      strokeCap(SQUARE);
      stroke(scaleColor(line, lineLength, c));
      line(0,0,line,0);
    }

    popMatrix();
  }
}