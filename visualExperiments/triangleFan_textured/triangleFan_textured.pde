PImage texture;
PImage textureTwo;

boolean textureBool = false;

int NUMSEGMENTS = 16;
// arrays to store the pre-calculated xy directions of all segments
float[] xL = new float[NUMSEGMENTS];
float[] yL = new float[NUMSEGMENTS];
float counter =0.0;

void setup() {
  size(700, 700, P3D);
  texture = loadImage("one.jpg");
  textureTwo = loadImage("two.jpg");
  textureMode(NORMAL);

  float step = TWO_PI/NUMSEGMENTS; // generate the step size based on the number of segments
  // pre-calculate x and y based on angle and store values in two arrays
  for (int i=0; i<xL.length; i++) {
    float theta = step * i; // angle for this segment
    xL[i] = sin(theta);
    yL[i] = cos(theta);
  }
  
}

void draw() {
  background(0);
  translate(width/2, height/2);
  pushMatrix();
  rotate(counter);
  beginShape(TRIANGLE_FAN);
 if (textureBool) {
    texture(texture);
  } else {
    texture(textureTwo);
  }
  
  vertex(0, 0, 0.5, 0.5);
  for (int i =0; i <NUMSEGMENTS+1; i++) {
    int im = i==NUMSEGMENTS?0:i; // make sure the end equals the start=
    drawVertex(im, 300);
  }
  endShape();
  popMatrix();
  counter+=0.01;
}

void drawVertex(int index, float diam) {
  float x = xL[index]*diam; // pre-calculated x direction times diameter
  float y = yL[index]*diam; // pre-calculated y direction times diameter
  // calculate texture coordinates based on the xy position
  if (textureBool) {
    float tx = x/texture.width+0.5;
    float ty = y/texture.height+0.5;
    
    // draw vertex with the calculated position and texture coordinates
  vertex(x, y, tx, ty);
  } else {
    float tx = x/textureTwo.width+0.5;
    float ty = y/textureTwo.height+0.5;
    
    // draw vertex with the calculated position and texture coordinates
  vertex(x, y, tx, ty);
  }
  
}

void mousePressed(){
 textureBool = !textureBool; 
}
