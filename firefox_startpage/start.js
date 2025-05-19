let currentView = 1;
let isTransitioning = false;
const TRANSITION_DURATION = 400;

function updateButtons() {
  document.querySelectorAll(".nav-button").forEach((btn) => {
    btn.classList.toggle("active", Number(btn.dataset.view) === currentView);
  });
}

function showView(targetView) {
  if (targetView === currentView || isTransitioning) return;

  isTransitioning = true;

  const fromEl = document.getElementById(`view${currentView}`);
  const toEl = document.getElementById(`view${targetView}`);
  const direction = targetView > currentView ? "left" : "right";

  toEl.classList.remove("active");
  toEl.style.transition = "none";
  toEl.style.transform = `translateX(${direction === "left" ? "100%" : "-100%"})`;
  toEl.style.opacity = "1";
  void toEl.offsetWidth; // force reflow
  toEl.style.transition = `transform ${TRANSITION_DURATION}ms ease, opacity ${TRANSITION_DURATION}ms ease`;
  toEl.style.transform = "translateX(0%)";
  toEl.classList.add("active");

  fromEl.style.transition = `transform ${TRANSITION_DURATION}ms ease, opacity ${TRANSITION_DURATION}ms ease`;
  fromEl.style.transform = `translateX(${direction === "left" ? "-100%" : "100%"})`;
  fromEl.style.opacity = "0";
  fromEl.classList.remove("active");
  fromEl.style.transition =
    "transform ${TRANSITION_DURATION}ms ease, opacity ${TRANSITION_DURATION}ms ease";
  fromEl.style.transform = `translateX(${direction === "left" ? "-100%" : "100%"})`;
  fromEl.style.opacity = "0";

  currentView = targetView;
  isTransitioning = false;
  updateButtons();
}

document.addEventListener("keydown", function (event) {
  if (event.ctrlKey && ["1", "2", "3"].includes(event.key)) {
    showView(Number(event.key));
  }
});

document.querySelectorAll(".nav-button").forEach((button) => {
  button.addEventListener("click", () => {
    const target = Number(button.dataset.view);
    showView(target);
  });
});
