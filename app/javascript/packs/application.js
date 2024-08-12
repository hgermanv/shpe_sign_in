// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

import "@hotwired/turbo-rails"
import "controllers"

function clickCaptured(event) {
  const element = target instanceof Element ? target : target instanceof Node ? target.parentElement : null;
   const candidate = element ? element.closest("input, button") : null;
   return candidate?.type == "submit" ? candidate : null;
}