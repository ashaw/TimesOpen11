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
    },

    toggle_data: function(){
        if (Lines.time === "day"){
            Lines.load_data(raw_data_night);
            Lines.time = "night";
            $("#topbar").addClass("night");
        } else {
            Lines.load_data(raw_data);
            Lines.time = "day";
            $("#topbar").removeClass("night");
        }
    },

    toggle_size: function(){
        if (Lines.size === "big"){
            $(".station-bar").addClass("mini");
            Lines.size = "small";
        } else {
            $(".station-bar").removeClass("mini");
            Lines.size = "big";
        }
    },

    to_night: function(){
        if(Lines.time === "day"){
            Lines.toggle_data();
            $(".time-night").addClass("selected");
            $(".time-day").removeClass("selected");
        }
    },

    to_day: function(){
        if(Lines.time === "night"){
            Lines.toggle_data();
            $(".time-day").addClass("selected");
            $(".time-night").removeClass("selected");
        }
    },

    to_small: function(){
        if(Lines.size === "big"){
            Lines.toggle_size();
            $(".size-small").addClass("selected");
            $(".size-big").removeClass("selected");
        }
    },

    to_large: function(){
        if(Lines.size === "small"){
            Lines.toggle_size();
            $(".size-big").addClass("selected");
            $(".size-small").removeClass("selected");
        }
    }

}

$(function(){
    Lines.load_data(raw_data);
    Lines.time = "day";
    Lines.size = "big";
    $(".time-day").click(Lines.to_day);
    $(".time-night").click(Lines.to_night);
    $(".size-small").click(Lines.to_small);
    $(".size-big").click(Lines.to_large);
})
