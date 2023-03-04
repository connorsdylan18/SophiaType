function startTypingTest() {
  return new Promise((resolve, reject) => {
    let inputField = document.getElementById("input");
    let textElement = document.getElementById("text");
    let gameMode = document.getElementById("mode").value; 
    let characters = textElement.textContent.trim().replace(/<[^>]+>/g, "").split(""); // Regex to target html tags
    let spannedText = "";
    characters.forEach((char) => {
      spannedText += `<span class="neutral">${char}</span>`;
    }); // Wrap each chracter with a span
    textElement.innerHTML = spannedText;
    let charElements = textElement.querySelectorAll("span");
    let inputValue;
    let startFlag = false;
    let start; // Stores start time. Initialised here so scoped for entire function
    let errors = 0;
    let uErrors = 0;
    let entries = 0;
    const timeLimit = 15; // time limit is non-adjustable at this time
    let timeoutId;

    inputField.addEventListener("input", function() {
      inputValue = inputField.value; 
      let prevLength = inputValue.length - 1;

      if (inputValue.length === prevLength + 1) {
        entries += 1;

        if (!startFlag) { // 
          start = new Date();
          startFlag = true;

          if (gameMode === "timed") {
            timeoutId = setTimeout(() => {
              let time = timeLimit/60;

              uErrors = endTest(inputField, inputValue, characters)

              resolve({ time, uErrors, errors, entries });
            }, timeLimit * 1000); // Takes time in milliseconds
          }
        } 

        let currentChar = charElements[inputValue.length - 1];
        let correctClass = inputValue[inputValue.length - 1] === currentChar.innerText ? "correct" : "error"; // Ternary operator checks if the character is correct or incorrect and assigns relevent class
        currentChar.classList.remove("neutral", "correct", "error");
        currentChar.classList.add(correctClass);
        errors += correctClass === "error" ? 1 : 0; // ternary operator to add to the error tally if the class is 'error'

        if (inputValue.length === characters.length) { // Ends test when input field is as long as the text
          let end = new Date();
          let time = (end - start)/60000; // Finds difference between start and end times to find time elapsed

          uErrors = endTest(inputField, inputValue, characters)

          resolve({ time, uErrors, errors, entries });
        
        }
      } 
    });

    inputField.addEventListener("keydown", function(event) {
      if (event.key === "Backspace") {
        let prevLength = inputField.value.length + 1;
        if (charElements[inputField.value.length] && inputField.value.length < prevLength) { // Checks that there is a character to manipulate, and that a characters has actually been deleted
          setTimeout(() => { // Timeout ensures that the backspace manipulations are executed before the rest of the code continues
            charElements[inputField.value.length].classList.remove("correct", "error")
            charElements[inputField.value.length].classList.add("neutral")
          }, 0);
        }
      }
    });
  });
}

function endTest(inputField, inputValue, characters) {
  let uErrors = 0;
  inputField.disabled = true;
  document.getElementById("typing-test").classList.add("hide");
  document.getElementById("results").classList.remove("hide"); // Hides the typing test and shows the results table

  for (let i = 0; i < inputValue.length; i++) { // Loops through the final value of the input field and counts the number of remaining incorrect characters
    if (inputValue[i] !== characters[i]) {
      uErrors += 1;
    }
  }
  return uErrors 
}

function calculateResults(time, uErrors, errors, entries) {
  let accuracy;
  let gWPM = (entries/5)/time;
  let nWPM = gWPM < (uErrors/time) ? 0 : gWPM - (uErrors/time); // nWPM is zero if the uErrors/time is greater than gWPM. Severe penalty for keyboard mashing!
  accuracy = 100 - (errors/entries * 100);
  let minutes = Math.floor(time);
  let seconds = Math.round((time - minutes) * 60);
  let formattedTime = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`; // Formats the time as minutes:seconds
  return {grossWPM: Math.round(gWPM), netWPM: Math.round(nWPM), totalAccuracy: Math.round(accuracy), formattedTime: formattedTime, time: time.toFixed(2) };
}


function displayResults(results) {
  const resultsArray = [ {id: "wpm", value: results.netWPM}, 
  {id: "accuracy", value: results.totalAccuracy}, 
  {id: "gross", value: results.grossWPM}, 
  {id: "time", value: results.formattedTime} ];
  resultsArray.forEach(item => { 
    document.getElementById(item.id).textContent = item.value;
  });
}


function createResult(results) { // Sends ajax POST request with results as params
  let xhr = new XMLHttpRequest();

  xhr.open("POST", "/results");

  let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  xhr.setRequestHeader("X-CSRF-Token", csrfToken);
  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onload = function() {
    if (!(xhr.status === 201)) {
      console.log("Error creating result: " + xhr.statusText);
    }
  };

  let data = JSON.stringify({
    result: {
      user_id: parseInt(document.getElementById("user-id").getAttribute("data-user-id")),
      netWPM: results.netWPM,
      grossWPM: results.grossWPM,
      accuracy: results.totalAccuracy,
      time: results.time  
    }
  });
  xhr.send(data);
}

function main() {
  document.addEventListener("keydown", function(event) { // Adds event listener listening for 'tab' key and reloads page
    if (event.key === "Tab") {
      event.preventDefault();
      window.location.reload(true);
    }
  });

  startTypingTest()
    .then(({ time, uErrors, errors, entries }) => {
      console.log(time, uErrors, errors, entries)
      return calculateResults(time, uErrors, errors, entries);
    })
    .then((results) => {
      console.log(results)
      displayResults(results);
      createResult(results);
    })
    .catch((error) => {
      console.error(error);
    });
}

main()
