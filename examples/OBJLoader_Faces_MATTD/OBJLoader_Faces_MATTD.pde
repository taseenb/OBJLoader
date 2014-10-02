import objloader.*;
import saito.objtools.*;

import processing.opengl.*;


// declare that we need a OBJModel and we'll be calling it "model"
OBJModel model;
float rotX;
float rotY;

int faceCount;
int face;

void setup()
{
  size(600, 600, OPENGL);

  // making an object called "model" that is a new instance of OBJModel
  model = new OBJModel(this);

  // turning on the debug output (it's all the stuff that spews out in the black box down the bottom)
  model.enableDebug();

  // enableLocalTexture is usefull if you're modeling package uses absolute paths when pointing to the diffuse testure (like XSI)
  // see mtl file in data folder for example
model.setTexturePathMode(OBJModel.ABSOLUTE);

  //setting the draw mode
  model.shapeMode(TRIANGLES);

  model.disableMaterial();

  model.load("cube_sphere_test.obj");



  println("the model has this many segments = " + model.getSegmentCount());

  for (int i = 0; i < model.getSegmentCount(); i ++){

    println("segment " + i + " has this many indexes = " + model.getIndexCountInSegment(i));

    for (int j = 0; j < model.getIndexCountInSegment(i); j ++){

      println(model.getVertexIndicesInSegment(i,j));

    }
  }

  faceCount = model.getIndexCountInSegment(0);

  noStroke();
}

void draw()
{
  background(128);
  lights();

  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(rotY);
  rotateY(rotX);
  scale(3);

  noFill();
  stroke(255);
  model.draw();

  int[] vertIndex = model.getVertexIndicesInSegment(0, face);
  
  fill(0);
  
  beginShape(TRIANGLES);

  for(int i = 0; i < vertIndex.length; i ++)
  {

    PVector v = model.getVertex(vertIndex[i]);

    vertex(v.x, v.y, v.z);

  }

  endShape();
  
  if(frameCount % 10 == 0)
  {
    face = (face + 1) % faceCount;
  }

  popMatrix();
}


void mouseDragged()
{
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}


