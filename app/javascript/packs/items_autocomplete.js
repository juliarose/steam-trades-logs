document.addEventListener("turbolinks:load", function() {
  // for skins fields
  $('*[data-behavior="autocomplete"][data-for="skins"]').easyAutocomplete({
    url: function(name) {
      return "/skins/search.json?q=" + name;
    },
    getValue: "name",
    requestDelay: 200
  });
  
  // for items fields
  $('*[data-behavior="autocomplete"][data-for="items"]').easyAutocomplete({
    url: function(name) {
      return "/items/search.json?q=" + name;
    },
    getValue: "name",
    requestDelay: 200
  });
});