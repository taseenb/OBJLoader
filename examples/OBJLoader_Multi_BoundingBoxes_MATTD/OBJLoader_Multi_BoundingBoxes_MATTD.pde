import objloader.*;

// declare that we need a OBJModel and we'll be calling it "model"
OBJModel model;
float rotX;
float rotY;

// these booleans will be used to turn on and off bits of the OBJModel
boolean bTexture = true;
boolean bStroke = false;
boolean bMaterial = true;

// and this is the PImage that we'll put on the model later
PImage swapToMe;

void setup()
{
    size(600, 600, P3D);
    //frameRate(30);
    //noStroke();

    // we'll be using this later to swap the texture on the model
    swapToMe = loadImage("UVSwap.jpg");

    // making an object called "model" that is a new instance of OBJModel
    model = new OBJModel(this, "cube_sphere_test.obj", "relative", TRIANGLES);

    // turning on the debug output (it's all the stuff that spews out in the black box down the bottom)
    model.enableDebug();

    model.scale(3);
}

void draw()
{
    background(128);
    lights();
    if(bStroke) {
        stroke(255,0,255);
    } 
    else {
        noStroke();
    }

    //this will do nothing until the model material is turned off
    fill(255,0,255);

    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(rotY);
    rotateY(rotX);

    model.draw();

    popMatrix();
}



void keyPressed() {
    // turns on and off the texture listed in .mtl file
    if(key == 't') {
        if(!bTexture) {
            model.enableTexture();
            bTexture = true;
        } 
        else {
            model.disableTexture();
            bTexture = false;
        }
    }

    else if(key == 'm') {
        // turns on and off the material listed in .mtl file
        if(!bMaterial) {
            model.enableMaterial();
            bMaterial = true;
        } 
        else {
            model.disableMaterial();
            bMaterial = false;
        }
    }

    else if(key == 's') {
        if(!bStroke) {
            stroke(255,0,255);
            bStroke = true;
        } 
        else {
            noStroke();
            bStroke = false;
        }
    }

    else if(key == 'c') {
        //clears loaded model
        model.reset();
        model.printModelInfo();
    }

    else if(key == 'r') {
        // will reload the model
        // without clearing the model first the data is added to the end of the last load
        // this is going to look bad (unless you're into glitch art)
        // so before load, clear the model
        model.reset();
        model.load("cube_sphere_test.obj");
        model.scale(3);
        model.printModelInfo();
    }

    else if(key == 'p') {
        // swaps the texture that was loaded from the mtl file to a PImage
        model.setTexture(swapToMe);
    }

    else if(key == 'o') {
        // sets the texture back to the original image
        model.originalTexture();
    }

    // the follwing changes the render modes
    // POINTS mode is a little flakey in OPENGL
    // the best one to use is the one you exported the obj as
    // when in doubt try TRIANGLES or QUADS
    else if(key=='1') {
        bStroke = true;
        model.shapeMode(POINTS);
    }

    else if(key=='2') {
        bStroke = true;
        model.shapeMode(LINES);
    }

    else if(key=='3') {
        model.shapeMode(TRIANGLES);
    }

    else if(key=='4') {
        model.shapeMode(POLYGON);
    }

    else if(key=='5') {
        model.shapeMode(TRIANGLE_STRIP);
    }

    else if(key=='6') {
        model.shapeMode(QUADS);
    }
}

void mouseDragged()
{
    rotX += (mouseX - pmouseX) * 0.01;
    rotY -= (mouseY - pmouseY) * 0.01;
}

