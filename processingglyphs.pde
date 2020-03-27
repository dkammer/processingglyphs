import java.util.*;
import processing.pdf.*;

float xo; 
float yo; 
boolean record = false;
boolean drawAxes = true;
boolean newValues = true;
boolean pause = false;
boolean start = true;
boolean showStatusbar = true;
int numDataItems = 1;
int numDimensions = 9;
int startTime = millis();
int waitTime = 1200;
GlyphType selectedGlyph = GlyphType.STAR;
List<List<float[]>> valuesList = new ArrayList<List<float[]>>();
String statusText = "";

void setup() { 
  size(700, 700);
}

void drawStatusbar() {
  fill(80,80,80, 200);
  noStroke();
  rect(0,660,700,40);
  fill(240,240,240);
  text("[p] Pause [r] Record [g] Glyphs [c] Colors [a] Axes [+][-] Items [UP][DOWN] Dimensions [h] Hide Status [SPACE] Quit", 8, 676);
  text(":: " + statusText, 8, 693);
}

float[] convertArray(List<Float> list) {
  float[] arr = new float[list.size()];
  int index = 0;
  for (Float value : list) {
    arr[index++] = value;
  }
  return arr;
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
  List<Float> min = new ArrayList<Float>();
  List<Float> max = new ArrayList<Float>();
  for (int i = 0; i < numDimensions; i++) {
    min.add(0.0);
    max.add(10.0);
  }
  int columnCount = 1;
  if (!pause) { 
      valuesList.clear();
  }
  for (int stars = 0; stars < 49; stars++) { 
    if (!pause) { 
      List<float[]> values = new ArrayList<float[]>();
      for (int i = 0; i < numDataItems; i++) {
        List<Float> vals = new ArrayList<Float>();
        for (int j = 0; j < numDimensions; j++) {
          vals.add(random(10));
        }
        values.add(convertArray(vals));
      }
      valuesList.add(values);
    }
    switch (selectedGlyph) {
    case STAR:
      starGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case FLOWER:
      flowerGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case PIE:
      pieGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case BAR:
      barGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case PIEEXPLOSION:
      pieexplosionGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case WHISKER:
      whiskerGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
      break;
    case RING:
      ringGlyph(xo, yo, glyphSize, convertArray(min), convertArray(max), valuesList.get(stars), null, drawAxes);
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
  if (showStatusbar) drawStatusbar();
}

void keyPressed() { 
  if (key == 'r') {
    record = !record;
    statusText = record ? "Started recording PDF files for each frame." : "Stopping recording of PDF files.";
  }
  if (key == 'h') {
    showStatusbar = !showStatusbar;
    statusText = showStatusbar ? "Showing status bar." : "Hiding status bar.";
  }
  if (key == 'a') {
    drawAxes = !drawAxes;
    statusText = drawAxes ? "Showing axes in glyphs." : "Hiding axes in glyphs.";
  }
  if (key == 'c') {
    for (int i = 0; i < randomColors.length; i++) {
      randomColors[i] = 0;
    }
    hue = random(1);
  }
  if (key >= 0x30 && key <= 0x39) {
    int num = Integer.parseInt(""+key);
    if(num > 0 && num <= GlyphType.values().length) {
      selectedGlyph = GlyphType.values()[num-1];
      statusText = "Changed glyph type to " + selectedGlyph.toString();
    }
  }
  if (key == 'g') {
    int newGlyph = (selectedGlyph.ordinal()+1) % GlyphType.values().length;
    selectedGlyph = GlyphType.values()[newGlyph];
    statusText = "Changed glyph type to " + selectedGlyph.toString();
  }
  if (key == '+') {
    numDataItems++;
    pause = false;
    statusText = "Showing "+ numDataItems + " data items in each glyph and unpaused item generation.";
  }
  if (key == '-' && numDataItems > 1) {
    numDataItems--;
    pause = false;
    statusText = "Showing "+ numDataItems + " data items in each glyph and unpaused item generation.";
  }
  if (key == 'p') {
    pause = !pause;
    statusText = pause ? "Paused." : "Unpaused.";
  }
  if (key == CODED) {
    if (keyCode == DOWN && numDimensions > 3) {
      numDimensions--;
    } else if (keyCode == UP) {
      numDimensions++;
    } 
    statusText = "Changed number of dimensions to " + numDimensions + " and unpaused item generation.";
    pause = false;
  }
  start = true;
  if (key == ' ') {
    endRecord();
    exit();
  }
}
