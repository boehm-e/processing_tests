import processing.video.*;

PImage destination;  
int WIDTH = 640;
int HEIGHT = 480;
Capture cam;
PGraphics img, txt;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();     
  destination = createImage(WIDTH, HEIGHT, RGB);
  //frameRate(4);
  txt = createGraphics(width, height);
}
float xoff = 0;
float yoff = 0;
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  //destination.loadPixels();
  //for (int x = 0; x < cam.width; x++) {
  //  for (int y = 0; y < cam.height; y++ ) {
  //    int loc = x + y*cam.width;
  //    destination.pixels[loc] = cam.pixels[loc];
  //  }
  //}   
  //destination.updatePixels();

  //image(destination, 0, 0);
  
  
  //int repeat = 75;
  //int wdth = cam.width / repeat;
  //for (int x = 0; x < cam.width; x+=wdth) {
  //  for (int y = 0; y < cam.height; y+=wdth ) {
  //    fill(cam.get(x, y));
  //    ellipse(x+wdth/2, y+wdth/2, wdth, wdth);
  //  }
  //}
  
    
  txt.beginDraw(); 
  txt.textSize(width/9);
  txt.textAlign(CENTER);
  txt.text("test text", width/2, height/2);
  txt.endDraw();
  image(txt, 50, 50);
  destination.loadPixels();
  for (int x = 0; x < txt.width; x++) {
    xoff += 0.002;
    for (int y = 0; y < txt.height; y++ ) {
      yoff += 0.002;
      float random = noise(x+xoff,y+yoff);
      int pos = (int)(radians(random)*100*width);
      //println(pos);
      int loc = x + y*txt.width;
      int test = txt.get(x,y);
      if (test == 0 && x+pos < txt.width && y+pos < txt.height) {
        loc = x+pos + (y+pos)*txt.width;
        destination.pixels[loc] = cam.pixels[loc];
      } else {
        destination.pixels[loc] = cam.pixels[loc];
      }
    }
  }   
  destination.updatePixels();
  image(destination, 0, 0);

}
