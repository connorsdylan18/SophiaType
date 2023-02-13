function startTypingTest() {
  return new Promise((resolve, reject) => {
    let inputField = document.getElementById("input");
    let wordsValue = document.getElementById("text").textContent;
    let characters = wordsValue.split("");
    let inputValue;
    let startFlag = false;
    let start;
    let errors = 0;
    let uErrors = 0;
    let entries = 0;

    inputField.addEventListener("input", function() {
      inputValue = inputField.value;
      let prevLength = inputValue.length - 1;
      
      if (inputValue.length === prevLength + 1) {

        entries += 1;

        if (!startFlag) {
          start = new Date();
          startFlag = true;
        } 

        if (inputValue[inputValue.length -1] !== characters[inputValue.length - 1]) {
          console.log(inputValue[inputValue.length -1], characters[inputValue.length - 1])
          errors += 1;
        }

        if (inputValue.length === wordsValue.length) {
          let end = new Date();
          let time = (end - start)/60000;

          document.getElementById("typing-test").classList.add("hide");
          document.getElementById("results").classList.remove("hide");

          for (let i = 0; i < wordsValue.length; i++) {
            if (inputValue[i] !== wordsValue[i]) {
              uErrors += 1;
            }
          }

          console.log(time, uErrors, errors, entries)
          resolve({ time, uErrors, errors, entries });
        
        }
      } 
    });
  });
}


function calculateResults(time, uErrors, errors, entries) {
  console.log(time)
  let accuracy
  let gWPM = (entries/5)/time;
  let nWPM = gWPM - (uErrors/time);
  if (errors === 0) {
    accuracy = 100;
  } else {
    accuracy = 100 - (errors/entries * 100);
  }
  return {grossWPM: gWPM, netWPM: nWPM, totalAccuracy: accuracy, time: time};
}


function displayResults(results) {
  console.log(results.time)
  const resultsArray = [ {id: "wpm", value: results.netWPM}, {id: "accuracy", value: results.totalAccuracy}, {id: "gross", value: results.grossWPM}, {id: "time", value: results.time} ];
  resultsArray.forEach(item => { 
    document.getElementById(item.id).textContent = item.value.toFixed(2);
  });
}


startTypingTest()
  .then(({ time, uErrors, errors, entries }) => {
    console.log(time)
    return calculateResults(time, uErrors, errors, entries);
  })
  .then((results) => {
    displayResults(results);
  })
  .catch((error) => {
    console.error(error);
  });
