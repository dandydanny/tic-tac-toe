// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$( document ).ready(function() {
  humanTurn = false;
  occupiedBoxes = ["9"]
  $(".box").click(function() {
    if (humanTurn && occupiedBoxes.indexOf(this.id) == -1) {
      humanTurn = false;
      occupiedBoxes.push(this.id)
      var data = {positions: this.id}
      $( this ).append( '<span class="letter" id="o">O</span>' );
      $.post( "/game", data, function( data ) {
        var temp = data.position.toString();
        occupiedBoxes.push(temp)
        $( "#" + data.position ).append( '<span class="letter" id="x">X</span>' );
        if (data.win == "pc") {
          $( ".gameover" ).show( "slow" );
          $( ".message" ).append( "<center>Computer Wins!</center>" );
        }
        else if (data.win == "tie"){
          $( ".gameover" ).show( "slow" );
          $( ".message" ).append( "<center>Cat's Tie!</center>" );
          // $(".end-img").show();
        }
        else {
        humanTurn = true;
        }
      });
    }
  });

  $(".button").click(function(e) {
    e.preventDefault()
    $(this).fadeOut("fast")
    $.get( "/game/new", function(data) {
    $( "#" + data.position ).append( '<span class="letter" id="x">X</span>' );
    humanTurn = true;
    })
  })

  $(".gameover").click(function(e) {
    e.preventDefault()
    location.reload();
  })
});
