function drawPath(){
  var c = $('#logocanvas')[0];
  var context = c.getContext('2d');
  context.fillStyle = "#fff";
  // context.beginPath();
  context.moveTo(0,0);
  context.lineTo(90,0);
  context.lineTo(90,100);
  context.fill();
  context.moveTo(50,0);
  context.lineTo(70,150);
  context.lineTo(90,0);
  context.fill();

  context.fillStyle = "#000";
  context.textAlign = "left";
  context.font = "small-caps bold 37pt 'Georgia'";
  context.fillText("Time",100,50);
  context.fillText("Tracker",100,100);
}
