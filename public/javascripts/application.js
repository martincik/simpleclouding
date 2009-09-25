$(document).ready(function(){

  $("div.collection div.item h1 a.edit").addClass('unvisible');
  $("div.collection div.item h1 a.destroy").addClass('unvisible');
  $("div.collection div.item h2 a.edit").addClass('unvisible');
  $("div.collection div.item h2 a.destroy").addClass('unvisible');

  $("div.collection div.item h1").mouseover(function() {
    $(this).children('a.edit').removeClass('unvisible');
    $(this).children('a.destroy').removeClass('unvisible');
    return false;
  });

  $("div.collection div.item h2").mouseover(function() {
    $(this).children('a.edit').removeClass('unvisible');
    $(this).children('a.destroy').removeClass('unvisible');
    return false;
  });

  $("div.collection div.item h1").mouseout(function() {
   $(this).children('a.edit').addClass('unvisible');
   $(this).children('a.destroy').addClass('unvisible');
   return false;
  });
  
  $("div.collection div.item h2").mouseout(function() {
   $(this).children('a.edit').addClass('unvisible');
   $(this).children('a.destroy').addClass('unvisible');
   return false;
  });

  $('div.common-show h1 a').click(function(){
    $('div.common-show p').toggle();
  });

});