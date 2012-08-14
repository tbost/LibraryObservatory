import controlP5.*;
ControlP5 controlP5;

InteractiveMap map;
ZoomButton out = new ZoomButton(5,30,14,14,false);
ZoomButton in = new ZoomButton(22,30,14,14,true);
PanButton up = new PanButton(14,50,14,14,UP);
PanButton down = new PanButton(14,82,14,14,DOWN);
PanButton left = new PanButton(5,66,14,14,LEFT);
PanButton right = new PanButton(22,66,14,14,RIGHT);
Button[] buttons = { 
  in, out, up, down, left, right };

PFont font1, font2;
