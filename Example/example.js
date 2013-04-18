//On your libraries

var FacebookFunctions = {
    $:function(id){
        return document.getElementById(id);
    },

    facebookShare:function(){
        window.plugins.facebook.available(
            function(response) {
                if (response) { //Social.Framework is available (it is checked against the iOS version)
                    parent.window.plugins.facebook.shareFacebookWall(
                        function(s){  }, 
                        function(e){  }, 
                        "Text to share", 
                        {
                            urlAttach: url,
                            imageAttach: imageUrl
                        }
                    );
                } else {
                    //The code if we can't use the Social.Framework
                }
            }
        );
    },
};


//To call the function
<a id="facebook-share" onclick="FacebookFunctions.facebookShare();"> Click to share on facebook </a> 