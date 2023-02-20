function startTypingTest() {
  return new Promise((resolve, reject) => {
    let inputField = document.getElementById("input");
    let textElement = document.getElementById("text");
    let timerElement = document.querySelector("#timer")
    let gameMode = document.querySelector("#mode").value 
    let wordsValue = textElement.textContent.trim().replace(/<[^>]+>/g, "");
    let characters = wordsValue.split("");
    let spannedText = "";
    characters.forEach((char) => {
      spannedText += `<span class="neutral">${char}</span>`;
    });
    textElement.innerHTML = spannedText;
    let inputValue;
    let charElements;
    let startFlag = false;
    let start;
    let errors = 0;
    let uErrors = 0;
    let entries = 0;
    let timeLimit = 15;
    let timeoutId;
    if (gameMode === "timed") {
      timerElement.classList.remove("hide")
    }

    inputField.addEventListener("input", function() {
      charElements = textElement.querySelectorAll("span") 
      inputValue = inputField.value;
      let prevLength = inputValue.length - 1;

      if (inputValue.length === prevLength + 1) {
        entries += 1;

        if (!startFlag) {
          start = new Date();
          startFlag = true;

          if (gameMode === "timed") {
            timeoutId = setTimeout(() => {
              let time = timeLimit/60;

              inputField.disabled = true;
              document.getElementById("typing-test").classList.add("hide");
              document.getElementById("results").classList.remove("hide");

              for (let i = 0; i < inputValue.length; i++) {
                if (inputValue[i] !== characters[i]) {
                  uErrors += 1;
                }
              }

              console.log(time, uErrors, errors, entries)
              resolve({ time, uErrors, errors, entries });
            }, timeLimit * 1000);
          }
        } 

        let currentChar = charElements[inputValue.length - 1];
        if (inputValue[inputValue.length - 1] !== currentChar.innerText) {
          errors += 1;
          currentChar.classList.remove("neutral", "correct")
          currentChar.classList.add("error");
        } else {
          currentChar.classList.remove("neutral", "error")
          currentChar.classList.add("correct");
        }

        if (inputValue.length === wordsValue.length) {
          let end = new Date();
          let time = (end - start)/60000;

          inputField.disabled = true;
          document.getElementById("typing-test").classList.add("hide");
          document.getElementById("results").classList.remove("hide");

          for (let i = 0; i < wordsValue.length; i++) {
            if (inputValue[i] !== characters[i]) {
              uErrors += 1;
            }
          }

          resolve({ time, uErrors, errors, entries });
        
        }
      } else if (inputValue.length < prevLength) {
        charElements[inputValue.length].classList.remove("correct", "error");
        textElement.textContent = spannedText;
        charElements = textElement.querySelectorAll("span");
      }
    });

    inputField.addEventListener("keydown", function(event) {
      if (event.key === "Backspace") {
        charElements = textElement.querySelectorAll("span"); 
        let prevLength = inputField.value.length + 1;
        if (charElements[inputField.value.length] && inputField.value.length < prevLength) {
          setTimeout(() => {
            charElements[inputField.value.length].classList.remove("correct", "error")
            charElements[inputField.value.length].classList.add("neutral")
          }, 0);
        }
      }
    });
  });
}


function calculateResults(time, uErrors, errors, entries) {
  let accuracy = 0
  let gWPM = (entries/5)/time;
  let nWPM = Math.abs(gWPM - (uErrors/time));
  if (errors === 0) {
    accuracy = 100;
  } else {
    accuracy = 100 - (errors/entries * 100);
  }
  return {grossWPM: Math.round(gWPM), netWPM: Math.round(nWPM), totalAccuracy: Math.round(accuracy), time: parseFloat(time.toFixed(2))};
}


function displayResults(results) {
  const resultsArray = [ {id: "wpm", value: results.netWPM}, {id: "accuracy", value: results.totalAccuracy}, {id: "gross", value: results.grossWPM} ];
  resultsArray.forEach(item => { 
    document.getElementById(item.id).textContent = item.value;
  });
  let minutes = Math.floor(results.time);
  let seconds = Math.round((results.time - minutes) * 60);
  let formattedTime = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
  document.getElementById("time").textContent = formattedTime;
}


function createResult(results) {
  var xhr = new XMLHttpRequest();

  xhr.open('POST', '/results');

  var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  xhr.setRequestHeader('X-CSRF-Token', csrfToken);
  xhr.setRequestHeader('Content-Type', 'application/json');

  xhr.onload = function() {
    if (xhr.status === 201) {
      var result = JSON.parse(xhr.responseText);
    } else {
      console.log('Error creating result: ' + xhr.statusText);
    }
  };

  console.log(results.accuracy)
  var data = JSON.stringify({
    result: {
      user_id: parseInt(document.getElementById('user-id').getAttribute('data-user-id')),
      netWPM: results.netWPM,
      grossWPM: results.grossWPM,
      accuracy: results.totalAccuracy,
      time: results.time
    }
  });
  console.log(data)
  xhr.send(data);
}

document.addEventListener("keydown", function(event) {
  if (event.key === "Tab") {
    event.preventDefault();
    window.location.reload(true);
  }
});

startTypingTest()
  .then(({ time, uErrors, errors, entries }) => {
    return calculateResults(time, uErrors, errors, entries);
  })
  .then((results) => {
    displayResults(results);
    createResult(results);
  })
  .catch((error) => {
    console.error(error);
  });

// class TypingTest {
//   constructor() {
//     this.inputField = document.getElementById("input");
//     this.textElement = document.getElementById("text");
//     this.timerElement = document.querySelector("#timer");
//     this.gameMode = document.querySelector("#mode").value;
//     this.wordsValue = this.textElement.textContent.trim().replace(/<[^>]+>/g, "");
//     this.characters = this.wordsValue.split("");
//     this.spannedText = "";
//     this.characters.forEach((char) => {
//       this.spannedText += `<span class="neutral">${char}</span>`;
//     });
//     this.textElement.innerHTML = this.spannedText;
//     this.inputValue;
//     this.charElements;
//     this.startFlag = false;
//     this.start;
//     this.errors = 0;
//     this.uErrors = 0;
//     this.entries = 0;
//     this.timeLimit = 15;
//     this.timeoutId;
//   }

//   startTypingTest() {
//     return new Promise((resolve, reject) => {
//       if (this.gameMode === "timed") {
//         this.timerElement.classList.remove("hide")
//       }

//       this.inputField.addEventListener("input", () => {
//         this.charElements = this.textElement.querySelectorAll("span") 
//         this.inputValue = this.inputField.value;
//         let prevLength = this.inputValue.length - 1;

//         if (this.inputValue.length === prevLength + 1) {
//           this.entries += 1;

//           if (!this.startFlag) {
//             this.start = new Date();
//             this.startFlag = true;

//             if (this.gameMode === "timed") {
//               this.timeoutId = setTimeout(() => {
//                 let time = this.timeLimit/60;

//                 this.inputField.disabled = true;
//                 document.getElementById("typing-test").classList.add("hide");
//                 document.getElementById("results").classList.remove("hide");

//                 for (let i = 0; i < this.inputValue.length; i++) {
//                   if (this.inputValue[i] !== this.characters[i]) {
//                     this.uErrors += 1;
//                   }
//                 }

//                 console.log(time, this.uErrors, this.errors, this.entries)
//                 resolve({ time, this.uErrors, this.errors, this.entries });
//               }, this.timeLimit * 1000);
//             }
//           } 

//           let currentChar = this.charElements[this.inputValue.length - 1];
//           if (this.inputValue[this.inputValue.length - 1] !== currentChar.innerText) {
//             this.errors += 1;
//             currentChar.classList.remove("neutral", "correct")
//             currentChar.classList.add("error");
//           } else {
//             currentChar.classList.remove("neutral", "error")
//             currentChar.classList.add("correct");
//           }

//           if (this.inputValue.length === this.wordsValue.length) {
//             let end = new Date();
//             let time = (end - this.start)/60000;

//             this.inputField.disabled = true;
//             document.getElementById("typing-test").classList.add("hide");
//             document.getElementById("results").classList.remove("hide");

//             for (let i = 0; i < this.wordsValue.length; i++) {
//               if (this.inputValue[i] !== this.characters[i]) {
//                 this.uErrors += 1;
//               }
//             }

//             resolve({ time, this.uErrors, this.errors, this.entries });
          
//           }
//         } else if (this.inputValue.length < prevLength) {
//           this.charElements[this.inputValue.length].classList.remove("correct", "error");
//           this.textElement.textContent = this.spannedText;
//           this.charElements = this.textElement.querySelectorAll("span");
//         }
//       });

//       this.inputField.addEventListener("keydown", (event) => {
//         if (event.key === "Backspace") {
//           this.charElements = this.textElement.querySelectorAll("span"); 
//           let prevLength = this.inputField.value.length + 1;
//           if (this.charElements[this.inputField.value.length] && this.inputField.value.length < prevLength) {
//             setTimeout(() => {
//               this.charElements[this.inputField.value.length].classList.remove("correct", "error")
//               this.charElements[this.inputField.value.length].classList.add("neutral")
//             }, 0);
//           }
//         }
//       });
//     });
//   }
// }