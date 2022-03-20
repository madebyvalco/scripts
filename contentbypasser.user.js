// ==UserScript==
// @name         mboost.me & rekonise.com Bypass
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  Bypasser for mboost.me & rekonise.com
// @author       Valco#7818
// @match        https://rekonise.com/*
// @match        https://mboost.me/a/*
// @icon         https://www.google.com/s2/favicons?domain=mboost.me
// @grant        none
// ==/UserScript==

window.onload = function() {

    if (document.location.origin == "https://rekonise.com") {

        setTimeout(() => {
            const button = document.getElementsByClassName("mat-focus-indicator unlock-button mat-flat-button mat-button-base mat-accent mat-button-disabled")[0]
            document.getElementsByClassName("mat-focus-indicator unlock-button mat-flat-button mat-button-base mat-accent mat-button-disabled")[0].removeAttribute("disabled")
            button.click()
        }, 500);

    } else if (document.location.origin == "https://mboost.me") {

        setTimeout(() => {
            const jsonData = document.getElementById("__NEXT_DATA__").innerHTML
            const formattedJson = JSON.parse(jsonData)

            window.location.href = formattedJson.props.initialProps.pageProps.data.targeturl
        }, 500);
    }
}
