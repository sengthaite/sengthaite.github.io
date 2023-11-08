window.calReadingTime = ev => {
    let wordsPerMinuteElem = document.getElementById("wordPerMinutes")
    let wordsPerMinute = parseFloat(wordsPerMinuteElem.value);
    let result;

    if (!wordsPerMinute) {
        wordsPerMinute = 200
        wordsPerMinuteElem.innerText = wordsPerMinute
    }

    let textLength = ev.value.split(" ").length;
    if (textLength > 0 && wordsPerMinute > 0) {
        let value = Math.ceil(textLength * 10 / wordsPerMinute) / 10;
        result = `${value} ${value > 1 ? "minutes" : "minute"}`;
    } else {
        result = `0 minute`
    }
    document.getElementById("readingTime").innerText = result;
};