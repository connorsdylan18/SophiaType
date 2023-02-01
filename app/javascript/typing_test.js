window.alert("Hello typing test!")

// Reference the input field and the text that is being tested
const input = document.getElementById("typing-test-input");
const words = document.getElementById("typing-test-text");
// Splits the text into an array of characters
const charactersArray = words.innerText.split("")

// Adds an event listener to the input field to detect inputs
input.addEventListener("input", () => {
  const inputValue = input.value;
  // Sets a flag to indicate if an input is correct
  let correct = true;

  // Loops through each word in the text 
  charactersArray.forEach((char, index) => {
    // Finds the 
    const inputChar = inputValue[index];
    if (char !== inputChar) {
      correct = flase;
      words.innerHTML = words.innerHTML.replace(
        char,
        `<span style="color: red;">${inputChar}</span>`
        );
    }
  });
});