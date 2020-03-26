import java.util.*;
import processing.pdf.*;

float xo; 
float yo; 
boolean record = false;
boolean drawAxes = true;
boolean newValues = true;
boolean pause = false;
boolean start = true;
int numDataItems = 3;
int startTime = millis();
int waitTime = 1200;
GlyphType selectedGlyph = GlyphType.STAR;
List<List<float[]>> valuesList = new ArrayList<List<float[]>>();

void setup() { 
  size(700, 700);
}

void draw() {
  int m = millis();
  if (m - startTime < waitTime && !start) {
    return;
  } else {
    startTime = m;
  }
  start  = false;
  startTime = millis();
  if (record) beginRecord(PDF, "frame-####.pdf"); 
  background(255, 255, 255);
  float glyphSize = 40;
  float padding = 10;
  int maxColumns = (int) (700 / (2 * (glyphSize + padding)));
  xo = glyphSize + padding; 
  yo = glyphSize + padding;
  float[] min = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  float[] max = { 10, 10, 10, 10, 10, 10, 10, 10, 10};
  int columnCount = 1;
  if (!pause) { 
      valuesList.clear();
  }
  for (int stars = 0; stars < 50; stars++) { 
    if (!pause) { 
      List<float[]> values = new ArrayList<float[]>();      
      for (int i = 0; i < numDataItems; i++) {
        float[] vals = { random(10), random(10), random(10), random(10), random(10), random(10), random(10), random(10), random(10) };
        values.add(vals);
      }
      valuesList.add(values);
    }
    switch (selectedGlyph) {
    case STAR:
      starGlyph(xo, yo, glyphSize, min, max, valuesList.get(stars), null, drawAxes);
      break;
    case FLOWER:
      flowerGlyph(xo, yo, glyphSize, min, max, valuesList.get(stars), null, drawAxes);
      break;
    case BAR:
      barGlyph(xo, yo, glyphSize, min, max, valuesList.get(stars), null, drawAxes);
      break;
    case PIEEXPLOSION:
      pieexplosionGlyph(xo, yo, glyphSize, min, max, valuesList.get(stars), null, drawAxes);
      break;
    }
    xo += 2 * (glyphSize + padding);
    if (columnCount++ % maxColumns == 0) {
      columnCount = 1;
      xo = glyphSize + padding;
      yo += 2 * (glyphSize + padding);
    }
  }
  if (record) endRecord();
}

void keyPressed() { 
  if (key == 'r') {
    record = !record;
  }
  if (key == 'a') {
    drawAxes = !drawAxes;
  }
  if (key == 'c') {
    for (int i = 0; i < randomColors.length; i++) {
      randomColors[i] = 0;
    }
  }
  if (key == 'g') {
    if (selectedGlyph == GlyphType.STAR) {
      selectedGlyph = GlyphType.PIEEXPLOSION;
    } else if (selectedGlyph == GlyphType.FLOWER) {
      selectedGlyph = GlyphType.STAR;
    } else if (selectedGlyph == GlyphType.BAR) {
      selectedGlyph = GlyphType.FLOWER;
    } else if (selectedGlyph == GlyphType.PIEEXPLOSION) {
      selectedGlyph = GlyphType.BAR;
    }
  }
  if (key == '+') {
    numDataItems++;
    pause = false;
  }
  if (key == '-' && numDataItems > 1) {
    numDataItems--;
    pause = false;
  }
  if (key == 'p') {
    pause = !pause;
  }
  if (key == CODED) {
    if (keyCode == DOWN && waitTime > 200) {
      waitTime -= 100;
    } else if (keyCode == UP) {
      waitTime += 100;
    } 
  }
  start = true;
  if (key == ' ') {
    endRecord();
    exit();
  }
}
