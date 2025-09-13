// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Change to true to allow Turbo
Turbo.session.drive = false

// Allow UJS alongside Turbo
// import jquery, { parseHTML } from "jquery";
// window.jQuery = jquery;
// window.$ = jquery;
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

document.addEventListener("turbo:load", () => {
  const form = document.getElementById("cut-yield-form");
  if (!form) return;

  const fields = [
    "board_length_whole", "board_length_numerator", "board_length_denominator",
    "piece_length_whole", "piece_length_numerator", "piece_length_denominator"
  ].map(id => document.getElementById(id));

  const piecesCountPreview = document.getElementById("pieces-count-preview");
  const wasteLengthPreview = document.getElementById("waste-length-preview");
  const SAW_THICKNESS = 1 / 8;

  function toRational(whole, numerator, denominator) {
    denominator = denominator || 1;
    return parseInt(whole || 0) + (parseInt(numerator || 0) / parseInt(denominator))
  }
  function updatePreview() {
    const boardLength = toRational(
      document.getElementById("board_length_whole").value,
      document.getElementById("board_length_numerator").value,
      document.getElementById("board_length_denominator").value
    );

    const pieceLength = toRational(
      document.getElementById("piece_length_whole").value,
      document.getElementById("piece_length_numerator").value,
      document.getElementById("piece_length_denominator").value
    );

    if (!boardLength || !pieceLength) {
      piecesCountPreview.textContent = 0;
      wasteLengthPreview.textContent = 0;
      return;
    }

    const piecesCount = Math.floor((boardLength + SAW_THICKNESS) / (pieceLength + SAW_THICKNESS));
    const wasteLength = boardLength - (piecesCount * pieceLength + SAW_THICKNESS * (piecesCount - 1));


    piecesCountPreview.textContent = piecesCount;
    wasteLengthPreview.textContent = wasteLength.toFixed(3);
  }

  fields.forEach(field => field.addEventListener("change", updatePreview));
  fields.forEach(field => field.addEventListener("input", updatePreview));

  updatePreview();
});
