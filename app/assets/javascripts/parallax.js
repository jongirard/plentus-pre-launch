$(window).bind('scroll',function(e){
    parallaxScroll();
});
 
function parallaxScroll(){
    var scrolled = $(window).scrollTop();
    $('.bs-masthead .bottom').css('top',(0-(scrolled*.2))+'px'); 
}
