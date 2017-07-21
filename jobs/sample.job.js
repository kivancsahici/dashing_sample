var current_valuation = 0;
var current_karma = 0;
// send_event('buzzwords', 
var items = [{"label":"Leverage","value":17},{"label":"Streamlininess","value":4},{"label":"Pivoting","value":3},{"label":"Turn-key","value":24},{"label":"Exit strategy","value":69}];

var labels = ['Leverage', 'Streamlininess', 'Pivoting', 'Turn-key', 'Exit strategy'];
var values = [17, 4, 14, 24, 25];
labels = labels.sort( function() { return 0.5 - Math.random() } );
values.sort( function() { return 0.5 - Math.random() } );

setInterval(function() {
  var last_valuation = current_valuation;
  var last_karma = current_karma;
  current_valuation = Math.floor(Math.random() * 100);
  current_karma = Math.floor(Math.random() * 200000);

  send_event('valuation', {current: current_valuation, last: last_valuation});
  send_event('karma', {current: current_karma, last: last_karma});
  send_event('synergy', {value: Math.floor(Math.random() * 100)});
  /*
  send_event('buzzwords', {"items":[{"label":"Leverage","value":17},{"label":"Streamlininess","value":4},{"label":"Pivoting","value":4},{"label":"Turn-key","value":24},{"label":"Exit strategy","value":25}],"id":"buzzwords","updatedAt":1496869137});
  */
  items.sort( function() { return 0.5 - Math.random() } );
  send_event('buzzwords', {"items":[items[0], items[1], items[2], items[3], items[4]],"id":"buzzwords","updatedAt":1496869137});
}, 2 * 1000);
