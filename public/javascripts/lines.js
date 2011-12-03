Lines = {

    width: 280,

    load_data: function(data){
        _($(".happy-bar")).each(function(bar){
            var station_id = $(bar).data("station_id"),
                happiness = data[station_id][0],
                total = data[station_id][2];
            $(bar).css({"width":happiness/total * Lines.width});
        });
        _($(".sad-bar")).each(function(bar){
            var station_id = $(bar).data("station_id"),
                happiness = data[station_id][1],
                total = data[station_id][2];
            $(bar).css({"width":happiness/total * Lines.width});
        });
    }

}

$(function(){
    Lines.load_data(raw_data);
})
