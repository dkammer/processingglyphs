color[] randomColors = new color[20];

enum GlyphType { 
  STAR, FLOWER, BAR, PIEEXPLOSION
};

color scaleColor(float val, float maxVal, color c) {
  int r = (int) map(val, maxVal, 0, red(c) / 1.5, red(c));
  int g = (int) map(val, maxVal, 0, green(c) / 1.5, green(c));
  int b = (int) map(val, maxVal, 0, blue(c) / 1.5, blue(c));
  return color(r, g, b, alpha(c));
}

void drawAxis(float lineLength) {
  stroke(50, 50, 50);
  strokeWeight(0.5);
  line(0, 0, lineLength, 0);
}

color getColor(color[] colors, int i) {
  color c;
  if (colors == null || colors.length - 1 < i) {
    if (randomColors[i] == 0) {
      randomColors[i] = color(random(255), random(255), random(255));
    }
    c = randomColors[i];
  } else {
    c = colors[i];
  }
  return c;
}
