import java.util.*;
import processing.pdf.*;

float xo; 
float yo; 
boolean record = false;
boolean drawAxes = true;
int numDataItems = 3;
enum Glyph { 
  STAR, FLOWER, BAR
};
Glyph selectedGlyph = Glyph.STAR;

void setup() { 
  size(700, 700);
}

void draw() { 
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
  for (int stars = 0; stars < 50; stars++) { 
    List<float[]> list = new ArrayList<float[]>();
    for (int i = 0; i < numDataItems; i++) {
      float[] vals = { random(10), random(10), random(10), random(10), random(10), random(10), random(10), random(10), random(10) };
      list.add(vals);
    }
    color[] col = { color(0, 159, 227), color(229, 57, 193), color(70, 70, 70) };
    switch (selectedGlyph) {
    case STAR:
      starGlyph(xo, yo, glyphSize, min, max, list, col, drawAxes);
      break;
    case FLOWER:
      flowerGlyph(xo, yo, glyphSize, min, max, list, col, drawAxes);
      break;
    case BAR:
      barGlyph(xo, yo, glyphSize, min, max, list, col, drawAxes);
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
  delay(500);
}

void keyPressed() { 
  if (key == 'r') {
    record = !record;
  }
  if (key == 'a') {
    drawAxes = !drawAxes;
  }
  if (key == 'g') {
    if (selectedGlyph == Glyph.STAR) {
      selectedGlyph = Glyph.BAR;
    } else if (selectedGlyph == Glyph.FLOWER) {
      selectedGlyph = Glyph.STAR;
    } else if (selectedGlyph == Glyph.BAR) {
      selectedGlyph = Glyph.FLOWER;
    }
  }
  if (key == '+') {
    numDataItems++;
  }
  if (key == '-' && numDataItems > 1) {
    numDataItems--;
  }
  if (key == ' ') {
    endRecord();
    exit();
  }
}
