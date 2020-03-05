$(function(){
    $("nav.primnav .userinfo section section").hide();
})
$(function(){
    $("#hamburger").change(function(){
        if($("input:checkbox[id='hamburger']").is(":checked")){
            $("input:checkbox[id='hamburger']").attr("disabled", true);
            setTimeout(function(){
                var targetImg = document.querySelector("nav.primnav .userinfo img");
                var playerImg = targetImg.animate([
                    {transform: 'translate(0)'},
                    {transform: 'translate(105px, 15px) scale(2.7)'},
                ], 300);
                playerImg.addEventListener('finish', function(){
                    targetImg.style.transform = 'translate(105px, 15px) scale(2.7)';
                });
                $("nav.primnav .userinfo section section").fadeIn(300);
                $(".primnav .icon").css("paddingLeft", "50px");
                $("input:checkbox[id='hamburger']").attr("disabled", false);
            }, 500);
        }
        else if($("input:checkbox[id='hamburger']").is(":checked")==false){
            $("input:checkbox[id='hamburger']").attr("disabled", true);
            setTimeout(function(){
                var targetImg = document.querySelector("nav.primnav .userinfo img");
                var playerImg = targetImg.animate([
                    {transform: 'translate(105px, 15px)'},
                    {transform: 'translate(0px, 0px) scale(1)'},
                ], 100);
                playerImg.addEventListener('finish', function(){
                    targetImg.style.transform = 'translate(0px, 0px) scale(1)';
                });
                $("nav.primnav .userinfo section section").fadeOut(100);
                $(".primnav .icon").css("paddingLeft", "19px");
                $("input:checkbox[id='hamburger']").attr("disabled", false);
            }, 500);
        }
    });
})