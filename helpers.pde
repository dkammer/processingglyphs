enum GlyphType { 
  STAR, FLOWER, BAR
};

void drawAxis(float lineLength) {
  stroke(50, 50, 50);
  strokeWeight(0.5);
  line(0, 0, lineLength, 0);
}

color getColor(color[] colors, int i) {
  color c;
  if (colors == null || colors.length - 1 < i) {
    c = color(random(255), random(255), random(255));
  } else {
    c = colors[i];
  }
  return c;
}
