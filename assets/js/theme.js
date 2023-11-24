const THEME = "sengthaite.theme"

const theme = localStorage.getItem(THEME) ?? "light"
const metaTheme = document.querySelector('meta[name="theme-color"]')

if (metaTheme) {
    document.documentElement.setAttribute("data-theme", theme)
    metaTheme.setAttribute("content", theme == "light" ? "#fafafa" : "#272727");

    let darkTheme = document.getElementById("dark-theme")
    let lightTheme = document.getElementById("light-theme")

    if (theme == "dark") {
        if (darkTheme) darkTheme.removeAttribute("disabled")
        if (lightTheme) lightTheme.setAttribute("disabled", "disabled")
        metaTheme.setAttribute("content", "#272727");
    } else {
        if (darkTheme) darkTheme.setAttribute("disabled", "disabled")
        if (lightTheme) lightTheme.removeAttribute("disabled")
        metaTheme.setAttribute("content", "#fafafa");
    }
}