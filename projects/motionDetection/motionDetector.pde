import gab.opencv.*;
import processing.video.*;


OpenCV opencv;
Capture video;
PImage frame;

float threshold = 50;

void setup() {

  size(1280, 720); 
  String[] cameras = Capture.list();
  printArray(cameras);
 
  //video = new Capture(this, cameras[5]);
  //video = new Capture(this, 1280, 720, "HP TrueVision HD Camera",30);
  video = new Capture(this, 640, 480, "HP TrueVision HD Camera", 30);
 

  opencv = new OpenCV(this, 640, 480);
  opencv.startBackgroundSubtraction(5, 3, 0.5);  
 
  video.start();
}



void draw() {

  opencv.loadImage(video);
  opencv.updateBackground();  
  frame = opencv.getSnapshot();
  image(frame, 0, 0);

  noFill();
  stroke(255, 0, 0);
  strokeWeight(2);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
     
}


void captureEvent(Capture c) {
  c.read();
}
