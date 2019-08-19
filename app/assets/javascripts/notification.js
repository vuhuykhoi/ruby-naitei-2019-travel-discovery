function ready(){
  /*$(document).click(function(e){
    if( !$(e.target).is(".notification_list_cover") && !$(e.target).is(".notification_wrapper a") ){
      if($(".notification_wrapper").hasClass("open") && !$(".notification_wrapper").hasClass("opened")){
        $(".notification_wrapper").addClass("opened");
      }
      else if($(".notification_wrapper").hasClass("opened")){
        $(".notification_wrapper").removeClass("opened").removeClass("open");
      }
    }
  });
  */
  $(".dropdown_notification").click(function(){
    console.log("dropdown click!");
    $(this).parent().toggleClass("open");
    console.log($(this).parent().attr("class").split(/\s+/));
  });
}
$(document).ready(ready);
$(document).on('page:load', ready);
