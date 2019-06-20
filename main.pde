PVector[] points;
int radius, timesTable;
int numPoints = 200;
float lerpAmount = 0;

void setup() {                                                                
  size(1248, 600);
  frameRate(30);
  radius = 250;
  timesTable = 2;
  points = getPoints(numPoints, width/2, height/2, radius); 
} 
           
void draw() {                                                                                                                                                                  
    background(0);
    
    stroke(255,0,0);
    noFill();       
    circle(width/2, height/2, radius*2);                
    
    
     
    stroke(255);
    // draw points                                                                                                                                             
    for (int i=0; i<points.length; i++) {
        point(points[i].x, points[i].y); 
    }
    
   
    lerpAmount += 0.01;
    if (lerpAmount >= 1) {
       timesTable = (timesTable + 1) % 300;
       lerpAmount = 0;
    }
    
     stroke(255,255,0);
     drawTimesTable(timesTable, lerpAmount);
   
   
}       
 
// returns an array of points positions on the circle
PVector[] getPoints(int numPoints, float centerX, float centerY, float radius) {
    PVector[] points = new PVector[numPoints];
    int i = 0;
    float angle = 2 * PI / numPoints;     
    for (float curAngle = 0f; curAngle <= 2*PI; curAngle += angle) {
        float x = radius * cos(curAngle);   
        float y = radius * sin(curAngle);
        points[i++] = new PVector(x + centerX,y + centerY); 
    } 
    return points; 
}

void drawTimesTable(int timesTable, float lerpAmount) {
    for (int i=1; i<numPoints; i++) {
        int product = (i * timesTable) % numPoints;
        int nextProduct = (i * (timesTable + 1)) % numPoints;
        
        float angleProduct = (2 * PI / numPoints) * product;
        float angleNextProduct = (2 * PI / numPoints) * nextProduct;
        
       
        float angle = lerp(angleProduct, angleNextProduct, lerpAmount);
        
        
       
        float destX = radius * cos(angle) + width/2;
        float destY = radius * sin(angle) + height/2;
        
        
        
        if (i == 120) {
           stroke(255);
        } else {
           stroke(255, 0, 0); 
        }
        
        line(points[i].x, points[i].y, destX, destY);
    }
}

