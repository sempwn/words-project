
$(function(){
    var arr = $.getJSON("home/index.json",function(data){
        var keywords = [];
        var urls = [];
        var descriptions =[];
        for (i = 0; i < data.length; i++){
            keywords.push(data[i].name);
            urls.push(data[i].url);
            descriptions.push(data[i].desc);
        }
        $( '#tags' ).autocomplete({
          source: keywords
        });
        $( "#tags" ).on( "autocompleteselect", function( event, ui ) {
            var i = keywords.indexOf(ui.item.label);
            window.newURL(keywords[i],descriptions[i],urls[i]);
                    
        });
    });

    $('#overview').click( function(){
        window.newURL('','','./home/index.json');
    });

});