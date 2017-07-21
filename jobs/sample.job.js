var current_valuation = 0;
var current_karma = 0;

var items = [{"label":"Leverage","value":17},{"label":"Streamlininess","value":4},{"label":"Pivoting","value":3},{"label":"Turn-key","value":24},{"label":"Exit strategy","value":69}, {"label":"Paradign shift","value":14}, {"label":"Web 2.0","value":57}, {"label":"Synergy","value":45}, {"label":"Enterprise","value":12}];

setInterval(function() {
  var last_valuation = current_valuation;
  var last_karma = current_karma;
  current_valuation = Math.floor(Math.random() * 100);
  current_karma = Math.floor(Math.random() * 200000);

  send_event('valuation', {current: current_valuation, last: last_valuation});
  send_event('karma', {current: current_karma, last: last_karma});
  send_event('synergy', {value: Math.floor(Math.random() * 100)});
  
  items.sort( function() { return 0.5 - Math.random() } );
  send_event('buzzwords', {"items":[items[0], items[1], items[2], items[3], items[4], items[5], items[6], items[7], items[8]],"id":"buzzwords","updatedAt":1496869137});
}, 2 * 1000);
