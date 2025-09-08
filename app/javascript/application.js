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

  const upArrow = icon.dataset.up;
  const downArrow = icon.dataset.down;

  const footerHeight = 100;

  const showFooter = () => {
    footer.style.bottom = "0px";
    trigger.style.bottom = footerHeight + "px"
    icon.src = downArrow;
  };

  const hideFooter = () => {
    footer.style.bottom = `-${footerHeight}px`;
    trigger.style.bottom = "0px";
    icon.src = upArrow;
  };

  let isHovering = false;
  let isLocked = false;

  const hoverOn = () => {
    if (isLocked) return;
    isHovering = true;
    showFooter();
  };

  const hoverOff = () => {
    if (isLocked) return;
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
    if (isLocked) {
      isLocked = false;
      hideFooter();
    }
    else {
      isLocked = true;
      showFooter();
    }

  });

});
