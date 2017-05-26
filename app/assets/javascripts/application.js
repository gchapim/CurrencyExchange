// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
//
$(document).ready(function(){
$("#button_AUD").on("click", function(){
    for(i=0; i< myChart.series.length; i++){
      if(myChart.series[i].name == 'AUD'){
        myChart.series[i].show()
      }else{
        myChart.series[i].hide()
      }
    }
});

$("#button_BRL").on("click", function(){
    for(i=0; i< myChart.series.length; i++){
      if(myChart.series[i].name == 'EUR'){
        myChart.series[i].show()
      }else{
        myChart.series[i].hide()
      }
    }
});

$("#button_USD").on("click", function(){
    for(i=0; i< myChart.series.length; i++){
      if(myChart.series[i].name == 'USD'){
        myChart.series[i].show()
      }else{
        myChart.series[i].hide()
      }
    }
});
});
