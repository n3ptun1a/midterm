let scene = 0;
let phoneGlow = 0;
let runSpeed = 0;
let girlX = 200;
let girlY = 300;
let distance = 1;
let buttonPressed = 0;
let hearts = [];
let heartSpawnRate = 5;

function setup() {
  createCanvas(400, 400);
}

function draw() {
  background(220);

  if (scene === 0) {
    drawGirl("smile");
  } else if (scene === 1) {
    drawGirl("disdain");
  } else if (scene === 2) {
    drawPhoneLoveBombing();
  } else if (scene === 3) {
    drawField();
  }
}

function drawGirl(expression) {
  background(220);

  // Hair
  fill(0);
  ellipse(200, 220, 140, 160);
  rect(150, 200, 100, 100);

  // Face
  fill(255, 220, 185);
  ellipse(200, 200, 100, 120);

  // Facial expression logic
  if (expression === "smile") {
    fill(0);
    ellipse(180, 190, 10, 10);
    ellipse(220, 190, 10, 10);
    noFill();
    stroke(0);
    arc(200, 210, 30, 10, 0, PI);
  } else if (expression === "disdain") {
    // Concerned look
    fill(0);
    ellipse(180, 190, 8, 10);
    ellipse(220, 190, 8, 10);
    
    stroke(0);
    strokeWeight(2);
    line(175, 180, 185, 185); // Left eyebrow
    line(225, 180, 215, 185); // Right eyebrow

    noFill();
    arc(200, 215, 30, 10, PI, 0); // Neutral mouth

    // Glow from phone
    phoneGlow = sin(frameCount * 0.3) * 50;
    noStroke();
    fill(255, 255, 200, 150 + phoneGlow);
    ellipse(200, 250, 100, 60);
  }

  noStroke();
  if (scene === 1) {
    fill(0);
    rect(170, 260, 60, 100, 10); // Phone
  }
}

function drawPhoneLoveBombing() {
  background(20);

  fill(255);
  rect(50, 20, 300, 360, 20); // Phone frame

  if (frameCount % heartSpawnRate === 0) {
    let x = random(80, 280);
    let y = 360;
    hearts.push(new Heart(x, y));
  }

  for (let i = 0; i < hearts.length; i++) {
    hearts[i].update();
    hearts[i].display();
  }

  if (hearts.length > 100) {
    hearts.splice(0, hearts.length - 100);
  }
}

function drawField() {
  background(50, 200, 50); // Grass

  fill(255, 220, 185);
  ellipse(girlX, girlY - distance * 5, 50 - distance, 60 - distance); // Face

  fill(0);
  ellipse(girlX, girlY - distance * 5 - 10, 60 - distance, 80 - distance); // Hair
  rect(girlX - 10, girlY - distance * 5, 20 - distance, 40 - distance); // Body

  // Glowing phone-button
  let glowLevel = map(buttonPressed, 0, 10, 50, 255);
  fill(0);
  rect(330, 350, 30, 50, 5); // Phone shape
  fill(255, 255, 200, glowLevel);
  ellipse(345, 375, 20, 20); // Glow "screen"

  // Movement
  if (buttonPressed > 0) {
    girlX -= runSpeed * 0.5;
    girlY -= runSpeed * 0.3;
    distance += runSpeed * 0.1;
  }
}

function mousePressed() {
  if (scene < 3) {
    scene++;
  } else if (scene === 3 && mouseX > 330 && mouseX < 360 && mouseY > 350 && mouseY < 400) {
    buttonPressed++;
    runSpeed = buttonPressed * 0.2;
  }
}

class Heart {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.size = random(15, 30);
    this.speed = random(1, 2);
    this.wiggle = random(0.05, 0.1);
    this.offset = random(100);
    this.r = random(200, 255);
    this.g = random(50, 100);
    this.b = random(100, 255);
  }

  update() {
    this.y -= this.speed;
    this.x += sin(frameCount * this.wiggle + this.offset);
  }

  display() {
    fill(this.r, this.g, this.b);
    noStroke();
    beginShape();
    vertex(this.x, this.y);
    bezierVertex(this.x - this.size / 2, this.y - this.size / 2,
                 this.x - this.size, this.y + this.size / 3,
                 this.x, this.y + this.size);
    bezierVertex(this.x + this.size, this.y + this.size / 3,
                 this.x + this.size / 2, this.y - this.size / 2,
                 this.x, this.y);
    endShape(CLOSE);
  }
} 