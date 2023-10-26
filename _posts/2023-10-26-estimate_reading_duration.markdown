---
title: Estimate Article Reading Duration
layout: content
duration: 1mn
tags: tools
js-src: /assets/js/estimate-reading-duration.js
---

# Calculate Reading Duration

<input type="text" id="wordPerMinutes" onkeyup="calReadingTime(this)" placeholder="Enter words per minutes" value="200" /> <span>words per minute</span>

<textarea class="textarea" onkeyup="calReadingTime(this)" placeholder="Add your text ..."></textarea>

<b>Duration spent reading in minutes:</b> <span id="readingTime">0 minute</span>