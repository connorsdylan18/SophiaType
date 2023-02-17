const btnGroup = document.querySelector("#mode-select");
let selectedOption;

btnGroup.addEventListener("click", (event) => {
  selectedOption = document.querySelector('input[name="mode"]:checked').dataset.value;    
  if (selectedOption === "timed") {
    document.querySelector("#size-select").classList.add("hide");
  } else {
    document.querySelector("#size-select").classList.remove("hide");
  }
});