const scrambleText = (text) => {
    let max = text.length;
    let result = [...text];
    const randomIndex = (min, max) => {
        return Math.round(Math.random() * (max - min) + min);
    };
    for (let i of Array.from({ length: max }, (v, k) => k)) {
        let tmp = result[i];
        let index = randomIndex(0, max);
        result[i] = result[index];
        result[index] = tmp;
    }
    return result.join("");
};

document.addEventListener("DOMContentLoaded", () => {
    let buttonJumble = document.getElementById("jumble")
    let resultView = document.getElementById("result")
    buttonJumble.addEventListener("click", ()=> {
        resultView.innerHTML = scrambleText(document.getElementById("orig-text").value)
    })
});
