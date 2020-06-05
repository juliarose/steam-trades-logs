// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "../stylesheets/application"

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")

global.$ = require("jquery")
global.toastr = require("toastr")

import "bootstrap/js/dist/alert"
import "bootstrap/js/dist/button"
import "bootstrap/js/dist/carousel"
import "bootstrap/js/dist/collapse"
import "bootstrap/js/dist/dropdown"
import "bootstrap/js/dist/index"
import "bootstrap/js/dist/modal"
import "bootstrap/js/dist/popover"
import "bootstrap/js/dist/scrollspy"
import "bootstrap/js/dist/tab"
import "bootstrap/js/dist/toast"
import "bootstrap/js/dist/tooltip"
import "bootstrap/js/dist/util"

require("packs/bootstrap")
require("packs/pagination")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
