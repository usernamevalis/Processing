import processing.serial.*;
import processing.opengl.*; //if you are going to render with opengl (GPU)

int counter = 0;
float spin = 0.0;

Serial port;
float a;
float b;
float c;
boolean click = false;

float move =0;

void setup() {
  size(1200, 800, OPENGL);
  println(Serial.list());
  port = new Serial(this, Serial.list()[2], 9600);
  frameRate(30);
}

void draw() {
  background(138);
  pointLight(255,255,255,600,0,20);
  translate(width/2, height/2);
  pushMatrix();
  rotateX(radians(30));
  rotateY(spin);
  spin+=0.01;
  if(click){
    noFill();
    stroke(0, 0, 255);
  }else{
    
    sphereDetail(50);
    noStroke();
    fill(255); 
  }
  translate(a, b);
  sphere(c);
  popMatrix();
}

void serialEvent( Serial p ) {
  String in = p.readStringUntil( '\n' );
  if ( in != null ) {
    if ( in.charAt(0) == 'A' ) {
      a = int(in.substring(1, in.length()-2));
      a = map(a, 0, 1023, -800, 800);
    } else if ( in.charAt(0) == 'B' ) {
      b = int(in.substring(1, in.length()-2));
      b = map(b, 0, 1023, -800, 800);
    } else if ( in.charAt(0) == 'C' ) {
      c = int(in.substring(1, in.length()-2));
      c = map(c, 0, 1023, 0, 800);
    } else if ( "click".equals( in.trim() )) {
      click =!click;
    }
  }
}

