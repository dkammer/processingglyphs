color[] randomColors = new color[20];
float golden_ratio_conjugate = 0.618033988749895;
float hue = random(1);

enum GlyphType { 
  STAR, FLOWER, BAR, PIEEXPLOSION
};

color hsv_to_rgb(float h, float s, float v) {
  float r = 0, g = 0, b = 0;
  int h_i = (int) (h*6);
  float f = h*6 - h_i;
  float p = v * (1 - s);
  float q = v * (1 - f*s);
  float t = v * (1 - (1 - f) * s);
  if (h_i == 0) {
    r = v;
    g = t;
    b = p;
  }
  if (h_i == 1) {
    r = q;
    g = v;
    b = p;
  }  
  if (h_i == 2) {
    r = p;
    g = v;
    b = t;
  }  
  if (h_i == 3) {
    r = p;
    g = q;
    b = v;
  }  
  if (h_i == 4) {
    r = t;
    g = p;
    b = v;
  }  
  if (h_i == 5) {
    r = v;
    g = p;
    b = q;
  }
  return color((int)(r*256), (int)(g*256), (int)(b*256));
}

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
  i = i % 20;  // we only generate up to 20 random colors
  if (colors == null || colors.length - 1 < i) {
    if (randomColors[i] == 0) {
      hue += golden_ratio_conjugate;
      hue %= 1;
      randomColors[i] = hsv_to_rgb(hue, 0.7, 0.95);
    }
    c = randomColors[i];
  } else {
    c = colors[i];
  }
  return c;
}
