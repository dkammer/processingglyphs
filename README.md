# Processing Glyphs

Small glyph library for Processing.

<img src="https://github.com/dkammer/processingglyphs/raw/master/flowerglyphs.png" alt="Flower Glyphs" width="600">

<img src="https://github.com/dkammer/processingglyphs/raw/master/starglyphs.png" alt="Star Glyphs" width="600">

## Installation and Running

1. The [Processing IDE](https://processing.org/download/) is required to launch the program. 
2. After installation of Processing, download or clone the repository and launch the Processing Sketch by opening the file _processingglyphs.pde_

## Running Demo

Inside the main sketch, random data is created to showcase the glyphs. Hit 'r' on the keyboard to record PDF files of each frame. Press 'r' again to deactivate recording. Press 'g' to switch between the glyph types. Hit space bar to terminate the demo program.

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
List<float[]> values
````

Provide the data for the glyph. For each attribute or dimension, you can specify the minimum values (e.g. from 0 to 0, or minus 10 to 10, ...). The maximum values are needed to scale the values in each axis of the glyph. You need to provide these as well. Finally, provide a list of list of values for each dimension of your data points. Note that not every glyph type is suitable to represent multiple data points at once. Star glyphs can represent up to 5-6 individual data points simultaneously, flower glyphs and other glyph types cannot do this in a sensible manner.

```java
color[] colors
boolean drawAxes
```

If you provide multiple data points to display in one glyph, you can provide an array of different colors. Otherwise, random colors are chosen. You can also specify whether to show axes or not. 