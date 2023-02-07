let inputField = document.getElementById("input");
let words = document.getElementById("text");
let startFlag = false;

function startTypingTest(startFlag) {

  let start;
  let errors = 0;
  let uErrors = 0;
  let entries = 0;

  inputField.addEventListener("input", function() {

    let inputValue = inputField.value;
    let prevLength = inputValue.length - 1;
    let wordsValue = words.textContent;
    
    if (inputValue.length === prevLength + 1) {

      entries += 1;

      if (!startFlag) {
        start = new Date();
        startFlag = true;
      } 

      if (inputValue[inputValue.length - 1] != wordsValue[inputValue.length - 1]) {
        document.getElementById("input").classList.add("incorrect");
        errors += 1;
      } else {
        document.getElementById("input").classList.remove("incorrect");
      }

      if (inputValue.length === wordsValue.length) {
        let end = new Date();
        let time = (end - start)/60000;

        document.getElementById("typing-test").classList.add("hide");

        for (let i = 0; i < wordsValue.length; i++) {
          if (inputValue[i] !== wordsValue[i]) {
            uErrors += 1;
          }
        }

        return time, uErrors, errors, entries
      
      }
    }
  });
}


function calculateResults(time, uErrors, errors, entries) {
  let gWPM = (entries/5)/time;
  let nWPM = gWPM - (uErrors/time);
  let accuracy = errors/entries * 100
  return gWPM, nWPM, accuracy
}

function displayResults() {
  //
}


let timeElapsed, uncorrectedErrors, totalErrors, allTypedEntries = startTypingTest(startFlag);
let grossWPM, netWPM, totalAccuracy = calculateResults(timeElapsed, uncorrectedErrors, totalErrors, allTypedEntries);

