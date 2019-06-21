PVector[] points;
int radius, timesTable;
int numPoints = 200;
float lerpAmount = 0;

void setup() {                                                                
  size(620, 620);
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
    
    lerpAmount += 0.015;
    if (lerpAmount >= 1) {
       timesTable = (timesTable + 1) % 300;
       lerpAmount = 0;
    }
     
    animateTimesTable(timesTable, lerpAmount);
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

void animateTimesTable(int timesTable, float lerpAmount) {
    float colorMax = 2*PI;
    colorMode(HSB, colorMax);
  
    for (int i=1; i<numPoints; i++) {
        int product = (i * timesTable) % numPoints;
        int nextProduct = (i * (timesTable + 1)) % numPoints;
        
        float angleProduct = (2 * PI / numPoints) * product;
        float angleNextProduct = (2 * PI / numPoints) * nextProduct;
        
        // get real angle before finding shortest path
        float colorAngle = lerp(angleProduct, angleNextProduct, lerpAmount);
        
        if (angleProduct < angleNextProduct) {
            angleNextProduct = angleNextProduct - 2*PI;
        }

        float angle = lerp(angleProduct, angleNextProduct, lerpAmount);
     
        float destX = radius * cos(angle) + width/2;
        float destY = radius * sin(angle) + height/2;   
        
        float hue = colorAngle;
        stroke(hue, colorMax, colorMax);
        
        line(points[i].x, points[i].y, destX, destY);
    }
    
    // reset color mode
    colorMode(RGB, 255);
}

void drawTimesTable(int timesTable) {
    for (int i=1; i<numPoints; i++) {
        int product = (i * timesTable) % numPoints;
        line(points[i].x, points[i].y, points[product].x, points[product].y);
    }
}

