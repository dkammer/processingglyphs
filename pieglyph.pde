void pieGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, float[] values, color c, boolean drawAxes) { 
  List<float[]> valuesList = new ArrayList<float[]>();
  valuesList.add(values);
  color[] colors = { c };
  pieGlyph(originX, originY, lineLength, minValues, maxValues, valuesList, colors, drawAxes);
}

void pieGlyph(float originX, float originY, float lineLength, float[] minValues, float[] maxValues, List<float[]> values, color[] colors, boolean drawAxes) {
  int numDimensions = maxValues.length;

  for (int i = 0; i < values.size(); i++) {
    // draw slices
    float lastAngle = 180;
    float[] val = values.get(i);
    color c = getColor(colors, i);
    float sum = 0;
    for (int j = 0; j < numDimensions; j++) {
        sum += map(val[j], minValues[j], maxValues[j], 0, lineLength);
    }
    for (int j = 0; j < numDimensions; j++) {
      float angle = map(val[j], minValues[j], maxValues[j], 0, lineLength);
      noStroke();
      fill(scaleColor(angle, lineLength, c));
      arc(originX, originY, lineLength * 2, lineLength * 2, lastAngle, lastAngle + radians(angle * 360 / sum));
      lastAngle += radians(angle * 360 / sum) % 360;
    }
  }    
}