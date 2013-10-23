$(window).bind('scroll',function(e){
    parallaxScroll();
});
 
function parallaxScroll(){
    var scrolled = $(window).scrollTop();
    $('.bs-masthead .bottom').css('top',(0-(scrolled*.5))+'px'); 
}
$(document).ready(function (){
	$('.bs-masthead .btn-solid').click(function() {
	    $('html, body').animate({
	        scrollTop: $('.bs-masthead .bottom').offset().top 
			}, 2500); 
	});
});