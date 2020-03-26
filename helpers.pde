color[] randomColors = new color[20];
float golden_ratio_conjugate = 0.618033988749895;
float hue = random(1);

enum GlyphType { 
  STAR, FLOWER, BAR, PIEEXPLOSION
};

color hsv2rgb(float h, float s, float v) {
  float k1 = (5+h/60)%6;
  float f1 = v - v*s*Math.max( Math.min(k1,Math.min(4-k1,1)), 0);
  float k2 = (3+h/60)%6;
  float f2 = v - v*s*Math.max( Math.min(k2,Math.min(4-k2,1)), 0);
  float k3 = (1+h/60)%6;
  float f3 = v - v*s*Math.max( Math.min(k3,Math.min(4-k3,1)), 0);

  return color((int)(f1*255), (int)(f2*255), (int)(f3*255));
} 

float[] rgb2hsv(color c) {
  float r = red(c) / 255;
  float g = green(c) / 255;
  float b = blue(c) / 255;
  float v = Math.max(r,Math.max(g,b));
  float n = v-Math.min(r,Math.min(g,b));
  float h = 0;
  if (n != 0 && (v==r)) {
    h = (g-b)/n;
  } else if (v==g) {
    h = 2+(b-r)/n;
  } else { 
    h = 4+(r-g)/n; 
  }
  if (h<0) h += 6;
  if (v==0) n = 0; else n = n/v;

  float[] result = { 60*h, n, v };
  return result;
} 

color scaleColor(float val, float maxVal, color c) {
  float[] hsv = rgb2hsv(c);
  float h = hsv[0];
  float s = hsv[1];
  float v = hsv[2];
  float scale = map(val, maxVal, 0, 1, 0);
  color rgb = hsv2rgb(h,scale,v);
  return color(red(rgb), green(rgb), blue(rgb), alpha(c));
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
      c = hsv2rgb(hue*360, 0.7, 0.95);
      randomColors[i] = c;
      // only needed for demo program!
      statusText = "Generated random color("+(int)red(c)+","+(int)green(c)+","+(int)blue(c)+").";
    }
    c = randomColors[i];
  } else {
    c = colors[i];
  }
  return c;
}
