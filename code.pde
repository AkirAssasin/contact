/* @pjs font='fonts/induction.ttf' */ 

var myfont = loadFont("fonts/induction.ttf"); 

ArrayList dots;

int startDelay;

int isDebug = 0;

int score = 0;
int gameState = 0;
int played = 0;
int scoreOffset = 0;

int bossX = 0;
int bossY = 0;
int bossHealth = 0;

int pX = 0;
int pY = 0;

int keyDelay = 0;

int width, height;

float diameter = 12.0;

void setup() {
    noCursor();
    width = 960;
    height = 800;
    size(width, height);
    dots = new ArrayList();
    background(0);
};
 
Number.prototype.between = function (min, max) {
    return this > min && this < max;
}; 

void draw() {
    pX = mouseX;
    pY = mouseY;
    stroke(0, 15);
    fill(0, 15);
    rect(0, 0, width, height);
    
    for (int i=dots.size()-1; i>=0; i--) {
             Particle d = (Dot) dots.get(i);
             d.update();
    }
    
    if (gameState == 0) {
        for (int i=dots.size()-1; i>=0; i--) {
             Particle d = (Dot) dots.get(i);
             dots.remove(i);
        }
        
        fill(255);
        if (played == 0) {
            textFont(myfont,60);
            text ("Contact",190 + random(-3,3),(height/2.8) + random(-3,3));
        } else {
            fill(255,0,0);
            textFont(myfont,60);
            text ("Crushed",(width/5) + random(-3,3),(height/3.2) + random(-3,3));
            fill(255);
            textFont(0,30);
            scoreOffset = 0;
            if (round(score/60) >= 10) {scoreOffset += 5;} 
            if (prevDots < 100) {scoreOffset -= 5;} 
        }
        
        textFont(0);
        
        if (mouseX.between(439,538) && mouseY.between(688,742)) {
            textSize(15);
            text ("dodge the boxes",width/2.2 + random(-1,1),height/1.2 + random(-1,1));
            fill(255);
            textSize(35);
        }
        
        textSize(40);
        text ("Start",width/2.15 + random(-1,1),height/1.5 + random(-1,1));
        text ("Help",width/2.15 + random(-1,1),height/1.1 + random(-1,1));
        
        stroke(255);
        fill(255);
        strokeWeight(8);
        line(mouseX,mouseY,pmouseX,pmouseY);
        if (isDebug == 1) {text(mouseX + ", " + mouseY,mouseX,mouseY);}
    };
    
    strokeWeight(1);
    
    if (gameState == 1) {
        fill(255);
        textSize(30);
        text(round(score/60) + "s",width/2 + random(-2,2),30 + random(-2,2));
        stroke(255);
        fill(255);
        strokeWeight(20);
        line(480,mouseY,480,pmouseY);
        strokeWeight(1);
        rect(470,mouseY - 50,20,100);
    };
};

void mouseClicked() {
    if (gameState == 0) {
        if (mouseX.between(435,545) && mouseY.between(495,540)) {
            score = 0;
            gameState = 1;
            played = 1;
        }
    };
};

void keyPressed() {
    if (key == 'D') {isDebug = 1;}
    if (key == 's') {dots.add(new Dot(0));}
};

class Dot {
    float x = 0.0;
    float y = 0.0;
    float vx = 0.0;
    float vy = 0.0;
    float rotation = 0;
    float type = 0;
    
    Dot(h) {
        x = width/2;
        y = height/2;
        vx = mouseX;
        vy = mouseY;
        type = h;
        rotation = atan2(vy - y, vx - x) / PI * 180;
    };
    
    void update(){
        x += cos(rotation/180*PI)*speed;
        y += sin(rotation/180*PI)*speed;
        fill(255);
        translate(x+5, y+5);  
        rotate(rotation/180*PI);  
        rect(-5, -5, 10, 10); 
        rotate(0-rotation/180*PI); 
        translate(-(x+5), -(y+5)); 
    }
}