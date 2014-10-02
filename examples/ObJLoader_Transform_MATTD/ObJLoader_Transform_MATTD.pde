import objloader.*;
import saito.objtools.*;

import processing.opengl.*;

// declare that we need a OBJModel and we'll be calling it "model"
OBJModel model;
float rotX;
float rotY;

int direction = 1;


void setup()
{
  size(600, 600, P3D);

  // making an object called "model" that is a new instance of OBJModel
  model = new OBJModel(this);

  // turning on the debug output (it's all the stuff that spews out in the black box down the bottom)
  model.enableDebug();

  // enableLocalTexture is usefull if you're modeling package uses absolute paths when pointing to the diffuse testure (like XSI)
  // see mtl file in data folder for example
  model.setTexturePathMode(OBJModel.ABSOLUTE);

  //setting the draw mode
  model.shapeMode(TRIANGLES);

//  model.disableMaterial();

  model.load("cube_sphere_test.obj");

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

  model.draw();
  popMatrix();
  
  for(int i = 0; i < model.getVertexCount(); i ++)
  {

    PVector v = model.getVertex(i);
    PVector n = model.getNormal(i);
    
    PVector tempn = new PVector(n.x, n.y, n.z);
    
    tempn.mult( direction );
        
    v.add(tempn);
    
  }
  
  if(frameCount % 20 == 0){
   direction = -direction; 
  }
}


void mouseDragged()
{
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}


