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

document.addEventListener("turbo:load", () => {
  const form = document.getElementById("miter-frame-form");
  if (!form) return;

  const miterAngleSpan = document.getElementById("miter-angle");
  const insidePreview = document.getElementById("inside-length-preview");
  const outsidePreview = document.getElementById("outside-length-preview");


  const fieldIds = [
    "inside-length-whole",
    "inside-length-numerator",
    "inside-length-denominator",
    "outside-length-whole",
    "outside-length-numerator",
    "outside-length-denominator",
    "board-width-whole",
    "board-width-numerator",
    "board-width-denominator",
    "shape_type"
  ]

  const fields = fieldIds.map(id => document.getElementById(id)).filter(el => el);

  function getValue(id, defaultValue = 0) {
    const el = document.getElementById(id);
    return el ? el.value : defaultValue;
  }


  function toDecimal(whole, numerator, denominator) {

    whole = parseInt(whole || 0);
    numerator = parseInt(numerator || 0);
    denominator = parseInt(denominator || 1);
    return whole + numerator / denominator;
  }

  function formatFraction(decimal) {
    const whole = Math.floor(decimal);
    let remainder = decimal - whole;
    const precision = 32;
    let numerator = Math.round(remainder * precision);
    let denominator = precision;
    // simplify for better tape measure type fractions
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const divisor = gcd(numerator, denominator);
    numerator /= divisor;
    denominator /= divisor;

    if (numerator === 0) return whole.toString();
    if (whole === 0) return `${numerator}/${denominator}`;
    return `${whole} ${numerator}/${denominator}`;
  }

  function numberOfSides(shape) {
    switch (shape) {
      case "triangle": return 3;
      case "rectangle": return 4;
      case "pentagon": return 5;
      case "hexagon": return 6;
      default: return 4;
    }
  }

  function updatePreview() {
    const shape = getValue("shape_type", "rectangle");
    const n = numberOfSides(shape);

    const inside = toDecimal(
      getValue("inside-length-whole"),
      getValue("inside-length-numerator"),
      getValue("inside-length-denominator")
    );

    const outside = toDecimal(
      getValue("outside-length-whole"),
      getValue("outside-length-numerator"),
      getValue("outside-length-denominator")
    );

    const board = toDecimal(
      getValue("board-width-whole"),
      getValue("board-width-numerator"),
      getValue("board-width-denominator")

    );

    if (!board || !n) return;

    const interiorAngle = ((n - 2) * 180) / n;
    const miterAngle = (180 - interiorAngle) / 2;
    miterAngleSpan.textContent = miterAngle.toFixed(2);

    const offset = 2 * board * Math.sin(miterAngle * Math.PI / 180);

    if (inside && !outside) {
      const outsideVal = inside + offset;
      outsidePreview.textContent = formatFraction(outsideVal);
      insidePreview.textContent = formatFraction(inside);
    }
    else if (outside && !inside) {
      const insideVal = outside - offset;
      insidePreview.textContent = formatFraction(insideVal);
      outsidePreview.textContent = formatFraction(outside);
    }
    else {
      insidePreview.textContent = "";
      outsidePreview.textContent = "";

    }
  }

  fields.forEach(field => {
    if (field) {
      field.addEventListener("change", updatePreview);
      field.addEventListener("input", updatePreview);
    }
  });

  updatePreview();


});
