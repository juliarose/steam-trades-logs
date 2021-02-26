document.addEventListener("turbolinks:load", function() {
  // for skins fields
  (function() {
    const $input = $('*[data-behavior="autocomplete"][data-for="skins"]');
    const options = {
      url: function(name) {
        return "/skins/search.json?q=" + name;
      },
      getValue: "name",
      requestDelay: 200
    };
    
    $input.easyAutocomplete(options);
  }());
  
  // for items fields
  (function() {
    const $input = $('*[data-behavior="autocomplete"][data-for="items"]');
    const options = {
      url: function(name) {
        return "/items/search.json?q=" + name;
      },
      getValue: "name",
      requestDelay: 200
    };
    
    $input.easyAutocomplete(options);
  }());
});