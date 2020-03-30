import controlP5.*;

int totalDots = 400;
float baseSpeed = 1.0;
float infectedRate = 1.0;
Dot[] dots = new Dot[totalDots];
 
//int width, height;
color fillColor;
float diameter = 12.0;

ControlP5 cp5; 
Slider[] s = new Slider[2];
Button b;

int[] nState = new int[4];
int counter = 0;

void setup() {
    // initialization
    size(1200, 800);
    // initial fill colour
    fillColor = color(255, 0, 0);
    fill(fillColor);
    noStroke();
    
    for(int i = 0; i < 4; i++){
      nState[i] = 0;
    }
    
    Reset();
    
    cp5 = new ControlP5(this);
    s[0] = cp5.addSlider("Speed coefficient", 0, 1, baseSpeed, 20, height - 130, 200, 20);
    s[1] = cp5.addSlider("Infected rate", 0, 1, infectedRate, 20, height - 90, 200, 20);
    
    b = cp5.addButton("Reset").setPosition(20, height - 50).setSize(100,40);
    background(0);

};

void Reset(){
  counter = 0;
  for (int i = 0; i < totalDots; i++) {
      Dot d = new Dot();
      d.x = random(width);
      d.y = random(height - 160);
      d.vx = random(2.0) - 1.0;
      d.vy = random(2.0) - 1.0;
      d.v = random(0.5) + 0.5;
      if(random(1.0) < 0.01){
        d.state = 1;
      }else{
        d.state = 0;
      }
      nState[d.state] ++;
      if(random(1.0) < 0.1){
        d.disease = 1;
      }else{
        d.disease = 0;
      }

      dots[i] = d;
  }
  background(0);
}

void draw() {
    fill(0, 100);
    rect(0, 0, width, height - 150);
 
    for (int i = 0; i < totalDots; i++) {
        dots[i].update();
        
        if(dots[i].state == 0){
          fill(255, 255, 255);
        }else if(dots[i].state == 1){
          fill(255, 255 - (int)(dots[i].idays / 500.0 * 250), 255);
        }else if(dots[i].state == 2){
          fill(200, 200, 200);
        }else if(dots[i].state == 3){
          fill(255, 0, 0);
        }

        for(int j = 0; j < totalDots; j++){
          if(i != j){
            if(abs(dots[i].x - dots[j].x) < diameter / 2.0){
              if(abs(dots[i].y - dots[j].y) < diameter / 2.0){
                if(random(1) < infectedRate){
                  if(dots[i].state == 1 && dots[j].state == 0){
                    dots[j].state = 1;
                  }
                  if(dots[i].state == 0 && dots[j].state == 1){
                    dots[i].state = 1;
                  }
                }
              }
            }
          }
        }
        ellipse(dots[i].x, dots[i].y, diameter, diameter);
    }
 
    for(int i = 0; i < 4; i++){
      nState[i] = 0;
    }
    for (int i = 0; i < totalDots; i++) {
      nState[dots[i].state] ++;
    }
    if(counter%10 == 0){
      int gh = height - 150;
      int dgh = 0;
      strokeWeight(1);
      stroke(255, 255, 255);
      dgh = (int) ((float)nState[0] / (float)totalDots * 150);
      line(300 + counter/10, gh, 300 + counter/10, gh + dgh);
      gh += dgh;
     
      stroke(255, 0, 255);
      dgh = (int)((float)nState[1] / (float)totalDots * 150);
      line(300 + counter/10, gh, 300 + counter/10, gh + dgh);
      gh += dgh;

      stroke(200, 200, 200);
      dgh = (int)((float)nState[2] / (float)totalDots * 150);
      line(300 + counter/10, gh, 300 + counter/10, gh + dgh);
      gh += dgh;
      
      stroke(255, 0, 0);
      dgh = (int)((float)nState[3] / (float)totalDots * 150);
      line(300 + counter/10, gh, 300 + counter/10, gh + dgh);
      noStroke();
    }    
    counter ++;
};
 
class Dot {
    float x = 0.0;
    float y = 0.0;
    float vx = 0.0;
    float vy = 0.0;
    float v = 0;
    int state = 0;  // 0: No infected, 1: Infected, 2: Recovered
    int idays = 0;  // days after infected / recovered
    int disease = 0;
    
    void update(){
      // update the velocity
      this.vx += random(2.0) - 1.0;
      this.vx *= v * baseSpeed;
      this.vy += random(2.0) - 1.0;
      this.vy *= v * baseSpeed;
      // update the position
      this.x += this.vx;
      this.y += this.vy;
      // handle boundary collision
      if (this.x > width) { this.x = width; this.vx *= -1.0; }
      if (this.x < 0) { this.x = 0; this.vx *= -1.0; }
      if (this.y > height - 160) { this.y = height - 160; this.vy *= -1.0; }
      if (this.y < 0) { this.y = 0; this.vy *= -1.0; }
      
      if (this.state == 1){
        if (this.idays < 500){          
          this.idays ++;
          if (this.disease == 1){
            this.v *= 0.995;
          }
        }else{
          if (this.disease == 0){
            this.state = 2;
            this.idays = 0;
          }else{
            this.state = 3;
            this.v = 0;
          }
        }
      }
      if (this.state == 2){
         if (this.idays < 500){          
          this.idays ++;
        }else{
          this.state = 0;
          this.idays = 0;
        }
      }
       
    }
}

void mousePressed(){
  s[0].updateInternalEvents(this);
  baseSpeed = s[0].getValue();
  s[1].updateInternalEvents(this);
  infectedRate = s[1].getValue();  
}
