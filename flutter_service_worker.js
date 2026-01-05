'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "38a94050bf1640583a3ce0590b6be71e",
"version.json": "a07d8bd594cce6033c300d9d89d41de4",
"index.html": "f7bf9dec00b417d3e9b582fab0d61b26",
"/": "f7bf9dec00b417d3e9b582fab0d61b26",
"main.dart.js": "2e9334418b4ac8ccf194a56371949626",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "703e3d1c7ced0060540d59400a591051",
"icons/Icon-192.png": "2c66f994d93346444e523e7d8a885278",
"icons/Icon-maskable-192.png": "2c66f994d93346444e523e7d8a885278",
"icons/logo.png": "73d403cbbf73def2aa538fc9dad69b65",
"icons/Icon-maskable-512.png": "5d6ff263f9bcd9fa1cf5d434f029fd35",
"icons/Icon-512.png": "5d6ff263f9bcd9fa1cf5d434f029fd35",
"manifest.json": "369e2adeef6a71caf0c758d8202e31b2",
"assets/NOTICES": "553152c494ab39bc58af126c517c1ea8",
"assets/FontManifest.json": "23d5e382cedd20ca8083c7dc0ab27c79",
"assets/AssetManifest.bin.json": "ee3a41101af3de7be9c637bb34e0656e",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "d8ea9aadcf0dcc9dc52a01928625d8e8",
"assets/fonts/MaterialIcons-Regular.otf": "5d4cc5d200f704c7fa0dd0bda7d5bbdd",
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
"assets/assets/contents/database/sql-fundamental.txt": "6737b34b22c0b14d79b6a983b9ddf63e",
"assets/assets/contents/database/database-useful-link.txt": "503d271214d4b1ceade3f737ce642afb",
"assets/assets/contents/biography/krom_ngoy.txt": "20c0eab5ea13b2f2d2e7eff25e2079c8",
"assets/assets/contents/general/coconut.txt": "6b0676d0f084c93c098e81b968bb34e4",
"assets/assets/contents/general/soy-source.txt": "a45589206daad47fda9f9e7759344313",
"assets/assets/contents/general/nginx-mac-homebrew.txt": "ced6fd10f0937edf56e8a797db23b726",
"assets/assets/contents/general/alan-turing.txt": "8fe5ef1938cb9013a148380a1db7eb15",
"assets/assets/contents/general/chrome-without-security-enable.txt": "cb1ceee928e51a8d318077a57ace4b03",
"assets/assets/contents/general/milk.txt": "faaf886c20e111d962cea52611538b22",
"assets/assets/contents/general/blood.txt": "7dba09e574be6e6c4bf5e18f7fe613da",
"assets/assets/contents/general/find-phone-number-cambodia.txt": "2981a9449acb13593caae6bf89055d56",
"assets/assets/contents/general/solid_principles.txt": "dd7ac4ca2ca95eb3987784afdd947c4f",
"assets/assets/contents/general/programming-challenges.txt": "3fad2fa7eb94fa964a5f7d2d2cbbfbed",
"assets/assets/contents/general/coffee.txt": "6c3b4c1cc7f56ca0cd9556ce1d369436",
"assets/assets/contents/general/pho.txt": "f1873def82bc55135a10ae032d883744",
"assets/assets/contents/general/durian.txt": "f0bf803ad42ef95204d71ce5ec98e263",
"assets/assets/contents/general/banana.txt": "582738b40c04c055ed86ca042898b036",
"assets/assets/contents/general/common-regex.txt": "016df3c9add6db15fbd92088b1ec6e40",
"assets/assets/contents/general/sustainable-development-goals.txt": "687b00c8eb8ff8ed16c5bb1f9664359e",
"assets/assets/contents/general/tmux.txt": "10e95bcc9036e0a5faba797cfb7cc6e0",
"assets/assets/contents/general/tea.txt": "e3e3133c895cee7d32ecf4c39eda73c0",
"assets/assets/contents/general/recover-file-mac.txt": "bc7ca0e9973a4ae4051f8afc58cef6a2",
"assets/assets/contents/general/citrus.txt": "85bf5956058fa79cef02fc086d3be5d5",
"assets/assets/contents/general/khmer-proverb.txt": "290e39cbf04a652ae57d01177a9d6f90",
"assets/assets/contents/general/client-app-common-features.txt": "f0e8557c2f6f20dc479af44c5610a026",
"assets/assets/contents/general/money.txt": "1587193efe6cf09aa4ea1d9a0de4eb8b",
"assets/assets/contents/general/garlic.txt": "823ca672f0ece3967097d7d3a3911166",
"assets/assets/contents/general/avocado.txt": "ff22631916c74e7a984a3489586eaf33",
"assets/assets/contents/general/wikimedia-foundation.txt": "c07e6282723918043b20fbaa7a6aad24",
"assets/assets/contents/llvm/the-c-programming-exercises.txt": "68d771c06047e657cc503eb2dfe638ae",
"assets/assets/contents/angular/common-angular.txt": "f6d33068a02ccd972f20cf09697fb3e5",
"assets/assets/contents/angular/angular-useful-link.txt": "b16a74f07f6285c34577c90b6a0a6921",
"assets/assets/contents/angular/angular-base-url.txt": "32aeaa721c4c42be45f0276a31ef53ba",
"assets/assets/contents/cli/ssh-to-termux-via-usb.txt": "db44ade77ccd35b5a3a6aee82432d42e",
"assets/assets/contents/reverse_engineer/reverse-engineer-roadmap.txt": "086ff087045bd89596a7da9ca38a214d",
"assets/assets/contents/ios/ios-dev-topics.txt": "ff509ae821f3de720828090534aed933",
"assets/assets/contents/ios/list-ios-app-bundleid.txt": "339a06f931fae627745e5d1ac0d034e8",
"assets/assets/contents/ios/ios-dev-roadmap.txt": "a4e0fbf0962f822ca59073a7875de440",
"assets/assets/contents/ios/ios_projects.txt": "ff0b681ed46c3101efc812589d58934a",
"assets/assets/contents/swift/useful-link-swift.txt": "3f3dec6f437192699958c62f0a43fee2",
"assets/assets/contents/swift/platforms-learning-swift.txt": "a72e23ee5765b7c684ed5bd57ca24d16",
"assets/assets/contents/swift/basic-swift.txt": "d2fe0d3a0f000e9e13aedddc21d3fafd",
"assets/assets/contents/swift/swift-general-information.txt": "e49237f727139b25f66685e7fc496c29",
"assets/assets/contents/swift/operators.txt": "9bdfffe4425ee5eccd25d0c3fcc85dd9",
"assets/assets/contents/android/android-studio-features.txt": "0af2a2227ffb817eb137deab79af03e0",
"assets/assets/contents/android/android-questions.txt": "0d081d2de84fa6cb9b1c3deab76c390c",
"assets/assets/contents/android/kotlin-learning-links.txt": "82a9dfaa4a991acdc090898dc5378bb8",
"assets/assets/contents/android/basic-kotlin.txt": "7750fb18d0898578804252dfc1b6ad58",
"assets/assets/contents/android/android-dev-roadmap.txt": "428dfb61907f711fbb77c0848b2799ea",
"assets/assets/contents/android/android-projects.txt": "22760a920ede42f1c9baff169701db02",
"assets/assets/contents/csharp/csharp_keywords.txt": "01ea05c0cf12fc3b586ba986e9c53df8",
"assets/assets/contents/csharp/dotnet_learning_resources.txt": "0ae333152ff4538216266cfd30f1edb9",
"assets/assets/contents/os/minix-kernel-roadmap.txt": "168c6d12e7f8a29d76fd393759f86882",
"assets/assets/contents/cambodia/name_of_provinces_cambodia.txt": "bced0089510ea7f9b6cd65c746da0562",
"assets/assets/contents/tool/developer-cli-tools.txt": "34d6618a1b6f58c8717d53adbf61cf17",
"assets/assets/autogen_meta/data_content.json": "583f927f7e68572db00f685803a86ed0",
"assets/assets/tool_icons/http.svg": "c51c16a6bd5185f37ccde7286a5bd1ad",
"assets/assets/tool_icons/qrcode.png": "ed949df50843628bb449ec175ed0e20a",
"assets/assets/tool_icons/camera.svg": "f42876ed16cc9e9137142675c5ad4b55",
"assets/assets/tool_icons/calculator.svg": "e21b1347dd2c810546ef6ecbbf6e4cb7",
"assets/assets/tool_icons/text_editor.svg": "57bb8fa1bc67d1be479ccf3f140b42ae",
"favicon.svg": "d40c0a60453bb2bb888455a589fe5316",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
