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
        let value = textLength / wordsPerMinute;
        result = `${value} ${value > 1 ? "minutes" : "minute"}`;
    }
    document.getElementById("readingTime").innerText = result;
};