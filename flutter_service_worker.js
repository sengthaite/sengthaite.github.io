'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "566e14d957039a1ce6f1d4c6ee9b1f3b",
"version.json": "a07d8bd594cce6033c300d9d89d41de4",
"index.html": "61b966b7a7889e215d5427946afe55fb",
"/": "61b966b7a7889e215d5427946afe55fb",
"main.dart.js": "0984b0066018f90429b2c4a505e549d6",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"icons/Icon-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"icons/Icon-maskable-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"icons/logo.png": "73d403cbbf73def2aa538fc9dad69b65",
"icons/Icon-maskable-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"icons/Icon-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"manifest.json": "d56f8fa717cc242cee960da48cc7f322",
"assets/AssetManifest.json": "2092a77fd386551d0b5898d0b492c43a",
"assets/NOTICES": "bacdc1d4098239dc801fa7d8df614267",
"assets/FontManifest.json": "87de055aa8b8ad0e4877fdf46d896587",
"assets/AssetManifest.bin.json": "51d328a9d66f470b368cb98724254c64",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ea10dacdf0e5e2ab90a36b487f7f7e83",
"assets/fonts/MaterialIcons-Regular.otf": "0e6d3bfec2d5080a711483b516303eb2",
"assets/assets/content_icons/cli.svg": "7862a1fb842db7d3168f4d67cd6ba0e8",
"assets/assets/content_icons/android.svg": "00340a5ba3ba63d0fc0004e31e2024a8",
"assets/assets/content_icons/llvm.svg": "28ede51cfdb79fa11ddc9be07cfc8511",
"assets/assets/content_icons/database.svg": "ae02a4b16b962817ec9af8978bc850cf",
"assets/assets/content_icons/angular.svg": "4a2fa660d71c6fdd62842aba7c4ed803",
"assets/assets/content_icons/maths.svg": "c70958153f060a5e214cf1e8998ae1df",
"assets/assets/content_icons/biography.svg": "45a8b869b90ace2d16f25163e32afcfd",
"assets/assets/content_icons/cambodia.svg": "715eed39876d0948dba2c39bb845b0d9",
"assets/assets/content_icons/tool.svg": "73384791b0409272fde44e1f25710589",
"assets/assets/content_icons/kotlin.svg": "bb1050a2565113f9b4a196aef5418fa2",
"assets/assets/content_icons/general.svg": "0eae05b54c765c8685a71b5f9bb8e1b5",
"assets/assets/content_icons/c%2523.svg": "1dd869b9c366d54b2dd63394a77d16cf",
"assets/assets/content_icons/os.svg": "d395d5e5d7877eff4c2bba3c72c3b202",
"assets/assets/content_icons/ios.svg": "1054f6024421fa65f78113b60f0c0277",
"assets/assets/content_icons/swift.svg": "be5dd307bbe29e1c750801ad8e574474",
"assets/assets/content_icons/logo.svg": "7856a5c00bbcba35c054b541b3c02a4f",
"assets/assets/content_icons/reverse_engineer.svg": "2b49c00466d04b49df9c34cf905416d1",
"assets/assets/contents/Database/sql-fundamental.txt": "f5919d050cad438448cfd28422f3add2",
"assets/assets/contents/Database/database-useful-link.txt": "503d271214d4b1ceade3f737ce642afb",
"assets/assets/contents/Biography/krom_ngoy.txt": "82ef890979ff7f7626ca71367af49410",
"assets/assets/contents/General/coconut.txt": "6b0676d0f084c93c098e81b968bb34e4",
"assets/assets/contents/General/soy-source.txt": "a45589206daad47fda9f9e7759344313",
"assets/assets/contents/General/nginx-mac-homebrew.txt": "ced6fd10f0937edf56e8a797db23b726",
"assets/assets/contents/General/alan-turing.txt": "2be97c31f2d6a07d37841af563fbe6b6",
"assets/assets/contents/General/chrome-without-security-enable.txt": "cb1ceee928e51a8d318077a57ace4b03",
"assets/assets/contents/General/milk.txt": "faaf886c20e111d962cea52611538b22",
"assets/assets/contents/General/blood.txt": "7dba09e574be6e6c4bf5e18f7fe613da",
"assets/assets/contents/General/find-phone-number-cambodia.txt": "2981a9449acb13593caae6bf89055d56",
"assets/assets/contents/General/solid_principles.txt": "dd7ac4ca2ca95eb3987784afdd947c4f",
"assets/assets/contents/General/programming-challenges.txt": "3fad2fa7eb94fa964a5f7d2d2cbbfbed",
"assets/assets/contents/General/coffee.txt": "bccc291bb8e51fec050df4405626eee1",
"assets/assets/contents/General/pho.txt": "f1873def82bc55135a10ae032d883744",
"assets/assets/contents/General/durian.txt": "08b262116806ecd9bd91e5136118c7d2",
"assets/assets/contents/General/banana.txt": "582738b40c04c055ed86ca042898b036",
"assets/assets/contents/General/common-regex.txt": "016df3c9add6db15fbd92088b1ec6e40",
"assets/assets/contents/General/sustainable-development-goals.txt": "687b00c8eb8ff8ed16c5bb1f9664359e",
"assets/assets/contents/General/tmux.txt": "10e95bcc9036e0a5faba797cfb7cc6e0",
"assets/assets/contents/General/tea.txt": "e3e3133c895cee7d32ecf4c39eda73c0",
"assets/assets/contents/General/recover-file-mac.txt": "bc7ca0e9973a4ae4051f8afc58cef6a2",
"assets/assets/contents/General/citrus.txt": "85bf5956058fa79cef02fc086d3be5d5",
"assets/assets/contents/General/khmer-proverb.txt": "290e39cbf04a652ae57d01177a9d6f90",
"assets/assets/contents/General/client-app-common-features.txt": "f0e8557c2f6f20dc479af44c5610a026",
"assets/assets/contents/General/money.txt": "1587193efe6cf09aa4ea1d9a0de4eb8b",
"assets/assets/contents/General/garlic.txt": "823ca672f0ece3967097d7d3a3911166",
"assets/assets/contents/General/avocado.txt": "2c0276818f17425ccb31b74a89388555",
"assets/assets/contents/General/wikimedia-foundation.txt": "c07e6282723918043b20fbaa7a6aad24",
"assets/assets/contents/LLVM/the-c-programming-exercises.txt": "68d771c06047e657cc503eb2dfe638ae",
"assets/assets/contents/Angular/common-angular.txt": "ef40e9388ba859bfb1573ea4b72adc3c",
"assets/assets/contents/Angular/angular-useful-link.txt": "b16a74f07f6285c34577c90b6a0a6921",
"assets/assets/contents/Angular/angular-base-url.txt": "32aeaa721c4c42be45f0276a31ef53ba",
"assets/assets/contents/CLI/ssh-to-termux-via-usb.txt": "db44ade77ccd35b5a3a6aee82432d42e",
"assets/assets/contents/iOS/ios-dev-topics.txt": "ff509ae821f3de720828090534aed933",
"assets/assets/contents/iOS/list-ios-app-bundleid.txt": "339a06f931fae627745e5d1ac0d034e8",
"assets/assets/contents/iOS/ios-dev-roadmap.txt": "a4e0fbf0962f822ca59073a7875de440",
"assets/assets/contents/iOS/ios_projects.txt": "ff0b681ed46c3101efc812589d58934a",
"assets/assets/contents/Swift/useful-link-swift.txt": "3f3dec6f437192699958c62f0a43fee2",
"assets/assets/contents/Swift/platforms-learning-swift.txt": "a72e23ee5765b7c684ed5bd57ca24d16",
"assets/assets/contents/Swift/basic-swift.txt": "d2fe0d3a0f000e9e13aedddc21d3fafd",
"assets/assets/contents/Swift/swift-general-information.txt": "e49237f727139b25f66685e7fc496c29",
"assets/assets/contents/Swift/operators.txt": "9bdfffe4425ee5eccd25d0c3fcc85dd9",
"assets/assets/contents/Android/android-studio-features.txt": "0af2a2227ffb817eb137deab79af03e0",
"assets/assets/contents/Android/android-questions.txt": "94d21d6286328f246bb4b512d92243ce",
"assets/assets/contents/Android/kotlin-learning-links.txt": "82a9dfaa4a991acdc090898dc5378bb8",
"assets/assets/contents/Android/basic-kotlin.txt": "7750fb18d0898578804252dfc1b6ad58",
"assets/assets/contents/Android/android-dev-roadmap.txt": "234242edc52b1a9ebba137933411d43e",
"assets/assets/contents/Android/android-projects.txt": "c600c16cf034fccaa4e4d69b09856a93",
"assets/assets/contents/C%2523/c%2523_keywords.txt": "01ea05c0cf12fc3b586ba986e9c53df8",
"assets/assets/contents/C%2523/dotnet_learning_resources.txt": "0ae333152ff4538216266cfd30f1edb9",
"assets/assets/contents/OS/minix-kernel-roadmap.txt": "168c6d12e7f8a29d76fd393759f86882",
"assets/assets/contents/Reverse%2520Engineer/reverse-engineer-roadmap.txt": "086ff087045bd89596a7da9ca38a214d",
"assets/assets/contents/Cambodia/name_of_provinces_cambodia.txt": "dfaaa8eb79cec176db837163268d173e",
"assets/assets/contents/Tool/developer-cli-tools.txt": "34d6618a1b6f58c8717d53adbf61cf17",
"assets/assets/autogen_meta/data_content.json": "7d79eca9df37d3fa1f0812182d5c4257",
"assets/assets/fonts/NotoSerifKhmer.ttf": "7796ba409432fde641c3179b46b741bc",
"assets/assets/fonts/FiraCode.ttf": "975eb23ba46d8164c8401e265af15fd7",
"assets/assets/tool_icons/text_editor.png": "e06cfc415a33faadc1a2315e4a98356c",
"favicon.svg": "d40c0a60453bb2bb888455a589fe5316",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
