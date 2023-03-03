function hideOptions() {
  const btnGroup = document.querySelector("#mode-select");
  // Selects the mode select button group by id

  btnGroup.addEventListener("click", (event) => {
    let selectedOption = document.querySelector('input[name="mode"]:checked').dataset.value;
    // Saves the selected button as a variable    
    if (selectedOption === "timed") {
      document.querySelector("#size-select").classList.add("hide");
    } else {
      document.querySelector("#size-select").classList.remove("hide");
    }
    // Adds the hide class when timed is selected, and removes it for the other two modes
  });
}

hideOptions()