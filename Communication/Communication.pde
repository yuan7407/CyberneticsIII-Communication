//Michael Yuan 17.03.30
//Update in 17.03.30
//Communication System Visualization

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
PImage img;
// A reference to our box2d world
Box2DProcessing box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle1> particles1;
ArrayList<Particle2> particles2;

//Boundary wall;

void setup() {
  size(1024, 529);
  img = loadImage("Shanghai.jpg");
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Create the empty list
  particles1 = new ArrayList<Particle1>();
  particles2 = new ArrayList<Particle2>();

  //wall = new Boundary(width/2, height-5, width, 10);
}

void draw() {
  background(img);
  textSize(28);
  fill(255);
  text("How do vehicles communicate with each other without a traffic system", 30, 50);
  
  if (random(1) < 0.1) {
    float sz = 6;
    particles1.add(new Particle1(random(width), 20, sz));
  }

  if (random(1) < 0.1) {
    float sz = 6;
    particles2.add(new Particle2(20, random(height), sz));
  }

  for (Particle2 b : particles2) {
    Vec2 wind = new Vec2(5, 1);
    b.applyForce(wind);
  }


  // We must always step through time!
  box2d.step();

  // Look at all particles
  for (int i = particles1.size()-1; i >= 0; i--) {
    Particle1 p = particles1.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles1.remove(i);
    }
  }
  for (int i = particles2.size()-1; i >= 0; i--) {
    Particle2 p = particles2.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles2.remove(i);
    }
  }

  //wall.display();
}


// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Particle1.class && o2.getClass() == Particle1.class) {
    Particle1 p1 = (Particle1) o1;
    p1.change();
    Particle1 p2 = (Particle1) o2;
    p2.change();
  }
  if (o1.getClass() == Particle2.class && o2.getClass() == Particle2.class) {
    Particle2 p1 = (Particle2) o1;
    p1.change();
    Particle2 p2 = (Particle2) o2;
    p2.change();
  }
}




// Objects stop touching each other
void endContact(Contact cp) {
}