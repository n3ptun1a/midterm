let scene = 0;
let phoneGlow = 0;
let runSpeed = 0;
let girlX = 200;
let girlY = 300;
let distance = 1;
let buttonPressed = 0;
let phoneOnScreen = false;

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
    drawPhoneScreen();
  } else if (scene === 3) {
    drawField();
  }
}

function drawGirl(expression) {
  background(220);

  // Hair (long, framing face)
  fill(0);
  ellipse(200, 220, 140, 160); // Hair volume
  rect(150, 200, 100, 100); // Long hair/messy bob

  // Face
  fill(255, 220, 185);
  ellipse(200, 200, 100, 120); 

  // Eyes & Mouth
  fill(0);
  ellipse(180, 190, 10, 10);
  ellipse(220, 190, 10, 10);

  if (expression === "smile") {
    noFill();
    arc(200, 210, 30, 10, 0, PI); // Smiling mouth
  } else if (expression === "disdain") {
    fill(255, 220, 185);
    rect(170, 180, 60, 20); // erases upper eyes
    line(180, 190, 190, 185);
    line(220, 190, 210, 185);
    ellipse(200, 215, 30, 10); // Straight faced

        // Phone glow effect
    phoneGlow = sin(frameCount * 0.1) * 50;
    fill(255, 255, 200, 150 + phoneGlow);
    ellipse(200, 250, 100, 60);
  }

  // Phone appearance
  if (scene === 1) {
    fill(0);
    rect(170, 260, 60, 100, 10);
  }
}

function drawPhoneScreen() {
  background(0);
  fill(255);
  rect(50, 20, 300, 360, 20); // Phone frame

  // Messages (received texts)
    textSize(20);
  fill(200);
  rect(80, 80, 180, 40, 10);
  fill(0);
  text("😍💖🥺", 120, 105);

  fill(200);
  rect(80, 140, 180, 40, 10);
  fill(0);
  text("💘😩✨", 120, 165);

  fill(200);
  rect(80, 200, 180, 40, 10);
  fill(0);
  text("💕😭🌹", 120, 225);

  fill(200);
  rect(80, 260, 180, 40, 10);
  fill(0);
  text("💞🥰🔥", 120, 285);
}

function drawField() {
  background(50, 200, 50); // Grass

  fill(255, 220, 185);
  ellipse(girlX, girlY - distance * 5, 50 - distance, 60 - distance); // Face

  // Hair
  fill(0);
  ellipse(girlX, girlY - distance * 5 - 10, 60 - distance, 80 - distance); 

  fill(0);
  rect(girlX - 10, girlY - distance * 5, 20 - distance, 40 - distance); // Body

  // Button
  fill(255, 0, 0);
  rect(320, 340, 60, 40, 10);
  fill(255);
  textSize(16);
  text("Run", 340, 365);
