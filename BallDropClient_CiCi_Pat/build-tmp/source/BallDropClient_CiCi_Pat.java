import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BallDropClient_CiCi_Pat extends PApplet {

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




Client myClient;                   // instance of the net Client
String data;                       // string to hold incoming data
String ipAddress = "127.0.0.1";    // address of the server goes here

public void setup() {
  // establish the background and foreground:
  size(400, 300);      
  background(50);
  fill(200);
  // Connect to server on port 8080
  myClient = new Client(this, ipAddress, 8080);
  background(0xff000045);
    fill(0xffeeeeff);
}

public void draw() {
  // If there's incoming data from the client:
  if (myClient.available() > 0) { 
    // get the data:
    data = myClient.readString(); 
    background(0xff000045);
    fill(0xffeeeeff);
    text(data, 10, 10);
  }
}

public void keyReleased() {
  // send out anything that's typed:
  //myClient.write(key);
  println("KEY = " + key);
  println("KEYCODE = " + keyCode);
  if (keyCode == 38){
    myClient.write("u\r");
  }
  if (keyCode == 40){
    myClient.write("d\r");
  }
  if (keyCode == 37){
    myClient.write("l\r");
  }
  if (keyCode == 39){
    myClient.write("r\r");
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BallDropClient_CiCi_Pat" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
