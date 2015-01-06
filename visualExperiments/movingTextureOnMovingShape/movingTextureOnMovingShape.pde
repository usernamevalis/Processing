int NUMSEGMENTS = 16; // the number of segments for the shapes
PImage texture;


// arrays to store the pre-calculated xy directions of all segments
float[] xL = new float[NUMSEGMENTS];
float[] yL = new float[NUMSEGMENTS];

float DIAM_FIXED = 350; // the diameter of the rotating shape with the fixed texture
float DIAM_INNER = 125; // the inner diameter of the moving shape with the moving texture
float DIAM_OUTER = 275; // the outer diameter of the moving shape with the moving texture

float fc1, fc2; // global variables used by many vertices for their dynamic movement

void setup () {

  size(1000, 800, P3D);
  textureMode(NORMAL);
  texture = loadImage("one.jpg");
  float step = TWO_PI/NUMSEGMENTS; // generate the step size based on the number of segments
  // pre-calculate x and y based on angle and store values in two arrays
  for (int i=0; i<xL.length; i++) {
    float theta = step * i; // angle for this segment
    xL[i] = sin(theta);
    yL[i] = cos(theta);
  }
}

void draw() {
  image(texture, 0, 0, width, float(width)/height*texture.height);
  fill(255,127);
   rect(0, 0, width, height);
  // 2. MOVING texture on a MOVING shape
  pushMatrix(); // use push/popMatrix so each Shape's translation does not affect other drawings
  translate(width/2, height/2); // translate to the right-center
  stroke(255); // set stroke to white
  beginShape(TRIANGLE_STRIP); // input the shapeMode in the beginShape() call
  texture(texture); // set the texture to use
  for (int i=0; i<NUMSEGMENTS+1; i++) {
    int im = i==NUMSEGMENTS?0:i; // make sure the end equals the start

    // each vertex has a noise-based dynamic movement
    float dynamicInner = 0.5 + noise(fc1+im);
    float dynamicOuter = 0.5 + noise(fc2+im);

    drawVertex(im, DIAM_INNER*dynamicInner); // draw the vertex using the custom drawVertex() method
    drawVertex(im, DIAM_OUTER*dynamicOuter); // draw the vertex using the custom drawVertex() method
  }
  endShape(); // finalize the Shape
  popMatrix(); // use push/popMatrix so each Shape's translation does not affect other drawings

  fc1 = frameCount*0.01;
  fc2 = frameCount*0.02;
}

void drawVertex(int index, float diam) {
  float x = xL[index]*diam; // pre-calculated x direction times diameter
  float y = yL[index]*diam; // pre-calculated y direction times diameter
  // calculate texture coordinates based on the xy position
  float tx = x/texture.width+0.5;
  float ty = y/texture.height+0.5;
  // draw vertex with the calculated position and texture coordinates
  vertex(x, y, tx, ty);
}

