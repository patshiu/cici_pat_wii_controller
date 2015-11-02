/*
  Ball Drop Client
 Language:  Processing
 
 Starts a network client that connects to a server on port 8080,
 sends any keystrokes pressed. 
 
 For use with the Ball Drop Server game.
 
 Created sometime in 2007
 modified 10 Sept 2012
 by Tom Igoe
 
 */


import processing.net.*;
import oscP5.*;
import netP5.*;

Client myClient;                   // instance of the net Client
String data;                       // string to hold incoming data
String ipAddress = "127.0.0.1";    // address of the server goes here

boolean downCombo = false;
boolean upCombo = false;

OscP5 oscP5;
NetAddress myRemoteLocation;
float pitch;



void setup() {
  // establish the background and foreground:
  size(400, 300);      
  background(50);
  fill(200);
  // Connect to server on port 8080
  myClient = new Client(this, ipAddress, 8080);
  // Start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  background(#000045);
    fill(#eeeeff);
}

void draw() {
  if (millis() % 5 == 0){
    checkTilt();
    println("CHECKING TILT");
  }
  
  // If there's incoming data from the client:
  if (myClient.available() > 0) { 
    // get the data:
    data = myClient.readString(); 
    background(#000045);
    fill(#eeeeff);
    text(data, 10, 10);
  }
  //println(upCombo);
}

void keyPressed() {
  // send out anything that's typed:
  //myClient.write(key);
  
  println("KEY = " + key);
  println("KEYCODE = " + keyCode);
  
  if (keyCode == 49){
    upCombo = true; 
  }
  
  if (keyCode == 50){
    downCombo = true; 
  }
  
  if (keyCode == 38){
    myClient.write("uuuu\r");
  }
  if (keyCode == 40){
    myClient.write("dddd\r");
  }
  if (keyCode == 37){
    if (upCombo == true){
      myClient.write("ul\r");
    }
    if (downCombo == true){
      myClient.write("ddddl\r");
    } 
    else {
    myClient.write("l\r");
    }
  }
  if (keyCode == 39){
    if (upCombo == true){
      myClient.write("ur\r");
    }
    if (downCombo == true){
      myClient.write("ddddr\r");
    }
    else {
      myClient.write("r\r");
    }
    
  }
}


void keyReleased() {
  if (keyCode == 49){
    upCombo = false; 
  }
  if (keyCode == 50){
    downCombo = false; 
  }
}

void checkTilt(){
  float SLIGHT_LEFT = 0.15; 
  float BALANCED_RANGE_LOWER = 0.45;
  float BALANCED_RANGE_UPPER = 0.75;
  float SLIGHT_RIGHT = 0.95;

  if (pitch >= BALANCED_RANGE_LOWER && pitch <= BALANCED_RANGE_UPPER){
    //don't move paddle
  }
  if (pitch > SLIGHT_LEFT && pitch < BALANCED_RANGE_LOWER ){
    //send "l"
    myClient.write("l\r");
  }
  if (pitch <= SLIGHT_LEFT){
    //send "ll"
    myClient.write("ll\r");
  }
  if (pitch > BALANCED_RANGE_UPPER && pitch < SLIGHT_RIGHT){
    //send "r"
    myClient.write("r\r");
  }
  if (pitch >= SLIGHT_RIGHT){
    //send "rr"
    myClient.write("rr\r");
  }

}

void oscEvent(OscMessage theOscMessage){
  pitch = theOscMessage.get(0).floatValue();
  //println(theOscMessage);
  //println("PITCH : " + pitch);
}
