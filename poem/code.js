function changecolor() {
  var x = document.querySelectorAll(".rhyme");
  
  var i;
  for (i = 0; i < x.length; i++) {
  	x[i].classList.toggle("colorrima");
  }
}

function showmetrica() {
  var x = document.querySelectorAll(".metrica");

  var i;
  for (i = 0; i < x.length; i++) {
  	x[i].classList.toggle("visible");
  }
}