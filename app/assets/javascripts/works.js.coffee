# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
   $('#works').dataTable( {
     sPaginationType: "full_numbers"
     bJQueryUI: true
     iDisplayLength: 10
     aoColumnDefs: [ { bSortable: false, aTargets: [ 0 ,1,2,3,4,5,6,7,8,9,10,11] } ]
     aaSorting: [[ 1, "desc"], [0, "desc"]]
       })
