document.addEventListener('turbolinks:load', function () {
  var elems = document.querySelectorAll('.tooltipped');
  var instances = M.Tooltip.init(elems, {
    // margin: 0
  });
});


document.addEventListener('turbolinks:load', function () {
  var elems = document.querySelectorAll('.fixed-action-btn');
  var instances = M.FloatingActionButton.init(elems, {
    direction: "left",
    hoverEnabled: false
  });
});

