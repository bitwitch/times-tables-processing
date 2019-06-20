PVector[] points;
int radius, timesTable;
int numPoints = 200;

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
    
    stroke(255,255,0);
    drawTimesTable(2);
   
}       
 
// returns an array of points positions on the circle
PVector[] getPoints(int numPoints, int centerX, int centerY, float radius) {
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

void drawTimesTable(int timesTable) {
    for (int i=1; i<numPoints; i++) {
        int product = (i * timesTable) % numPoints;
        line(points[i].x, points[i].y, points[product].x, points[product].y);
    }
}

