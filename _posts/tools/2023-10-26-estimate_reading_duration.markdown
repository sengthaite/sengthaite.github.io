---
title: Estimate Article Reading Duration
layout: content
duration: 1mn
tags: tools
js-src: /assets/js/estimate-reading-duration.js
---

<input type="text" id="wordPerMinutes" onchange onpropertychange onkeyuponpaste oninput="calReadingTime(this)" placeholder="Enter words per minutes" value="150" /> <span>words per minute</span>

<textarea style="width: 80vw; min-height: 50vh; resize: none;" class="textarea" onchange onpropertychange onkeyuponpaste oninput="calReadingTime(this)" placeholder="Add your text ..."></textarea>

<b>Estimated duration spent reading in minutes:</b> <span id="readingTime">0 minute</span>
