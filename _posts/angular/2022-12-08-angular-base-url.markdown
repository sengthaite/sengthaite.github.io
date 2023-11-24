---
title: Base url angular
layout: content
duration: 2mn
tags: angular
---

## Problem
> When building angular app for hosting with the following command.

```sh
npm run build
```

> The compiled project is generated as **dist/my-project/ with files: *3rdpartylicenses.txt*, *favicon.ico*, *index.html*, *main.xxxxxxxxxxxx.js*, *polyfills.xxxxxxxxxxxxxx.js*, etc.

> **Note**: {my-project} is your project name.

> Assume the nginx webroot is: /Users/sengthai.te/Public/webroot and running on port 8080. !When copy the compile project **my-project** from the **dist** to the path /Users/sengthai.te/Public/webroot. Then restart the nginx service. After go to browser and input the url: "localhost:8080/my-project", it is not working.

## Solution

> One solution is to update the root module file in angular. Example update file **app.module.ts** with APP_BASE_HREF.

```sh
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import {APP_BASE_HREF} from '@angular/common';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [{provide: APP_BASE_HREF, useValue: '/my-project'}],
  bootstrap: [AppComponent]
})
export class AppModule { }

```
> After saved and rebuild. Then delete the old deployment and move my-project that has just been built to the /Users/sengthai.te/Public/webroot. Restart the nginx services. Everything should work fine now.