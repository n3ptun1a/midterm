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
