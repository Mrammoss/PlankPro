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
  const icon = document.getElementById("footer-icon");

  if (!footer || !trigger || !icon) return;

  const upArrow = "icon.dataset.up";
  const downArrow = "icon.dataset.down";


  const showFooter = () => {
    footer.style.bottom = "0";
    icon.src = downArrow;
  };

  const hideFooter = () => {
    footer.style.bottom = "-100px";
    icon.src = upArrow;
  };

  let isHovering = false;

  const hoverOn = () => {
    isHovering = true;
    showFooter();
  };

  const hoverOff = () => {
    isHovering = false;
    setTimeout(() => {
      if (!isHovering) hideFooter();
    }, 50);
  };

  trigger.addEventListener("mouseenter", hoverOn);
  trigger.addEventListener("mouseleave", hoverOff);

  footer.addEventListener("mouseenter", hoverOn);
  footer.addEventListener("mouseleave", hoverOff);

  trigger.addEventListener("click", () => {
    if (footer.style.bottom === "0px") {
      hideFooter();
    }
    else {
      showFooter();
    }

  });

});
