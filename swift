let scene = 0;
let phoneGlow = 0;
let runSpeed = 0;
let girlX = 200;
let girlY = 300;
let distance = 1;
let buttonPressed = 0;
let phoneOnScreen = false;
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

  // Hair (long, framing face)
  fill(0);
  ellipse(200, 220, 140, 160);
  rect(150, 200, 100, 100);

  // Face
  fill(255, 220, 185);
  ellipse(200, 200, 100, 120);

  // Eyes & Mouth
  fill(0);
  ellipse(180, 190, 10, 10);
  ellipse(220, 190, 10, 10);

  if (expression === "smile") {
    noFill();
    arc(200, 210, 30, 10, 0, PI);
  } else if (expression === "disdain") {
    fill(255, 220, 185);
    rect(170, 180, 60, 20);
    line(180, 190, 190, 185);
    line(220, 190, 210, 185);
    ellipse(200, 215, 30, 10);

    // Phone glow effect
    phoneGlow = sin(frameCount * 0.3) * 50;
    fill(255, 255, 200, 150 + phoneGlow);
    ellipse(200, 250, 100, 60);
  }

  if (scene === 1) {
    fill(0);
    rect(170, 260, 60, 100, 10);
  }
}

function drawPhoneLoveBombing() {
  background(20);

  // Phone frame
  fill(255);
  rect(50, 20, 300, 360, 20);

  // Add new hearts over time
  if (frameCount % heartSpawnRate === 0) {
    let x = random(80, 280);
    let y = 360;
    hearts.push(new Heart(x, y));
  }

  // Update hearts
  for (let i = 0; i < hearts.length; i++) {
    hearts[i].update();
    hearts[i].display();
  }

  // Limit number of hearts
  if (hearts.length > 100) {
    hearts.splice(0, hearts.length - 100);
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

function drawField() {
  background(50, 200, 50); // Grass

  fill(255, 220, 185);
  ellipse(girlX, girlY - distance * 5, 50 - distance, 60 - distance); // Face

  fill(0);
  ellipse(girlX, girlY - distance * 5 - 10, 60 - distance, 80 - distance); 

  fill(0);
  rect(girlX - 10, girlY - distance * 5, 20 - distance, 40 - distance);

  // Button
  fill(255, 0, 0);
  rect(320, 340, 60, 40, 10);
  fill(255);
  ellipse(350, 360, 10, 10); // abstract button indicator

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
  } else if (scene === 3 && mouseX > 320 && mouseX < 380 && mouseY > 340 && mouseY < 380) {
    buttonPressed++;
    runSpeed = buttonPressed * 0.2;
  }
}