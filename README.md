# Processing Glyphs

Small glyph library for Processing.

## Glyphs

Currently supported glyph types:

   * Star (aka Radar, Spideweb)
   * Flower
   * Bar
   * Pie
   * Pie Explosion
   * Whisker
   * Ring 

<img src="https://github.com/dkammer/processingglyphs/raw/master/starglyphs.png" alt="Star Glyphs" height="150"> <img src="https://github.com/dkammer/processingglyphs/raw/master/flowerglyphs.png" alt="Flower Glyphs" height="150"> <img src="https://github.com/dkammer/processingglyphs/raw/master/barglyphs.png" alt="Bar Glyphs" height="150">

<img src="https://github.com/dkammer/processingglyphs/raw/master/pieglyphs.png" alt="Pie Glyphs" height="150"> <img src="https://github.com/dkammer/processingglyphs/raw/master/pieexplosionglyphs.png" alt="Pie Explosion Glyphs" height="150"> <img src="https://github.com/dkammer/processingglyphs/raw/master/whiskerglyphs.png" alt="Whisker Glyphs" height="150">

<img src="https://github.com/dkammer/processingglyphs/raw/master/ringglyphs.png" alt="Ring Glyphs" height="150">

## Installation and Running

1. The [Processing IDE](https://processing.org/download/) is required to launch the program. 
2. After installation of Processing, download or clone the repository and launch the Processing Sketch by opening the file _processingglyphs.pde_

## Running Demo

Inside the main sketch, random data is created to showcase the glyphs. 

   * Hit 'r' on the keyboard to record PDF files of each frame. Press 'r' again to deactivate recording. 
   * Press 'g' to switch between the glyph types. 
   * You can also use numbers to switch between the glyph types.
   * Pressing 'c' will clear the randomly generated colors and create new ones.
   * Pressing 'a' will switch between showing axes and hiding them. 
   * Using '+' and '-' you can increase and decrease the amount of data items shown in one glyph. 
   * Press 'p' to pause the program by stopping to create new data items. This is useful to compare glyph types for the same data. Press 'p' again to continue.
   * Pressing UP and DOWN on the keyboard will increase the number of dimensions shown in each glyph.
   * Hit space bar to terminate the demo program.

## API

Each glyph function has the same signature:

```java
void starGlyph(float originX, float originY, float lineLength, 
               float[] minValues, float[] maxValues, List<float[]> values, 
               color[] colors, boolean drawAxes)
```

The parameters are as follows:

```java
float originX
float originY
float lineLength
````

Provide the origin of the glyph (middle point). The line length refers to the length of _one_ axis of the glyph. That means a glyph is twice the line length of an axis in width!

```java
float[] minValues
float[] maxValues
List<float[]> values  // or: float[] values
````

Provide the data for the glyph. For each attribute or dimension, you can specify the minimum values (e.g. from 0 to 0, or minus 10 to 10, ...). The maximum values are needed to scale the values in each axis of the glyph. You need to provide these as well. Finally, provide a list of list of values for each dimension of your data points. You can also provide a single list of values for only one data item. Note that not every glyph type is suitable to represent multiple data points at once. Star glyphs can represent up to 5-6 individual data points simultaneously, flower glyphs and other glyph types cannot do this in a sensible manner.

```java
color[] colors  // or: color c
boolean drawAxes
```

If you provide multiple data points to display in one glyph, you can provide an array of different colors or a single color if you only pass the values of a single data item. Otherwise, random colors are chosen. If you provide *null* as parameter for the color random color will be chosen. You can also specify whether to show axes or not. Note that not every glyph type supports axes.

## Usage and Example

Simply add the PDE files for the glyphs (and the helper functions) you want to use in your Processing sketch and you can begin drawing. You can also clear the draw() function in the example sketch provided in this repository. See this smaller example below on how to use the glyph functions:

```java
void setup() { 
   // create a sketch with dimensions 700 x 700  
   size(700, 700);
}

void draw() {
   noLoop();                   // no loop needed
   background(255, 255, 255);  // set background to white

   // we have 9 dimensions or attributes (columns in your data table) 
   // for each data item, every dimension ranges from 0-10
   float[] min = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
   float[] max = { 10, 10, 10, 10, 10, 10, 10, 10, 10};  

   // create random sample values for two data points 
   // or rows in your data table
   float[] vals1 = { random(10), random(10), random(10), random(10), random(10), 
                     random(10), random(10), random(10), random(10) };
   float[] vals2 = { random(10), random(10), random(10), random(10), random(10), 
                     random(10), random(10), random(10), random(10) };

   // now draw two different glyphs in different locations
   // note that you can also pass arrays of values and colors
   // when you want a glyph to display more than one data item
   starGlyph(200, 200, 100, min, max, vals1, color(229, 57, 193), true);
   flowerGlyph(500, 200, 100, min, max, vals2, color(0, 159, 227), true);
}
```

## TODO

  * Change axes system for pie explosion glyph
  * Implement categorical color scale for glyphs
  * Add radial bar glyphs
  * Add possibility to print a legend for the dimensions
  * Create class for glyph configuration
  * Create class for reading CSV data and displaying glyphs
  * <strike>Add ring glyphs</strike>
  * <strike>Add whisker glyphs</strike>
  * <strike>Add pie glyphs</strike>
  * <strike>Add pie explosion glyphs</strike>
  * <strike>Add bar glyphs</strike>
  * <strike>Display hotkeys in demo program</strike>
  * <strike>Make transparency configurable</strike>
  * <strike>Remove busy wait from demo program</strike>