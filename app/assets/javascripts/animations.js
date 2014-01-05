$(document).ready(function(){
	$('.app-promo').animate({marginTop: '-=20px'});
	$(".scroll").click(function(event){
	         event.preventDefault();
	         //calculate destination place
	         var dest=0;
	         if($(this.hash).offset().top > $(document).height()-$(window).height()){
	              dest=$(document).height()-$(window).height();
	         }else{
	              dest=$(this.hash).offset().top;
	         }
	         //go to destination
	         $('html,body').animate({scrollTop:dest}, 500,'swing');
	     });
});

$(window).bind('scroll',function(){
    parallaxScroll();

});
 
function parallaxScroll(){
	var scrolled = $(window).scrollTop();
    $('.bs-masthead.home .bottom').css('top',(0-(scrolled*.2))+'px'); 
}

var total = 0, last_scroll = 0, buffer = 0, rate = 2, diff = 0, decay_rate = 0.5;

window.setInterval(function() {
	var st = $(window).scrollTop();
	diff = Math.abs(st - last_scroll);
	last_scroll = st;
	buffer = Math.max(buffer, diff) * decay_rate;
	if (buffer > 0) {
	                total -= buffer * rate;
					var seconds = total / 30,
						minutes = total / 60;
						
	    var srotate = "rotate(" + ((seconds * 6) - 90) + "deg)";
		
	    $(".cog-large").css({"-moz-transform" : srotate, "-webkit-transform" : srotate});
		$(".cog-small").css({"-moz-transform" : srotate, "-webkit-transform" : srotate});
	}
}, 100);

