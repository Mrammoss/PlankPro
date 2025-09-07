// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Change to true to allow Turbo
Turbo.session.drive = false

// Allow UJS alongside Turbo
import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;
import Rails from "@rails/ujs"
Rails.start();

document.addEventListener("turbo:load", () => {
  const footer = document.getElementById("dynamic-footer");
  const trigger = document.getElementById("footer-trigger");

  if (!footer || !trigger) return;
  trigger.addEventListener("mouseenter", () => {
    footer.style.bottom = "0";
  });

  trigger.addEventListener("mouseleave", () => {
    footer.style.bottom = "-100px";
  });

  trigger.addEventListener("click", () => {
    if (footer.style.bottom === "0px") {
      footer.style.bottom = "-100px";
    }
    else {
      footer.style.bottom = "0";
    }

  });

});
