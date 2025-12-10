'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "f7bf9dec00b417d3e9b582fab0d61b26",
"/": "f7bf9dec00b417d3e9b582fab0d61b26",
"icons/Icon-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"icons/Icon-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"icons/logo.png": "73d403cbbf73def2aa538fc9dad69b65",
"icons/Icon-maskable-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"icons/Icon-maskable-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"flutter_bootstrap.js": "42dee3ea60842611957dc2743adfce2d",
"assets/NOTICES": "bb49cbdd6d15b19d75dd870bba85a822",
"assets/AssetManifest.bin": "d0db0be423cddf62275ed1ef7c7a8f05",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/assets/content_icons/llvm.svg": "28ede51cfdb79fa11ddc9be07cfc8511",
"assets/assets/content_icons/reverse_engineer.svg": "2b49c00466d04b49df9c34cf905416d1",
"assets/assets/content_icons/android.svg": "00340a5ba3ba63d0fc0004e31e2024a8",
"assets/assets/content_icons/c%2523.svg": "1dd869b9c366d54b2dd63394a77d16cf",
"assets/assets/content_icons/angular.svg": "4a2fa660d71c6fdd62842aba7c4ed803",
"assets/assets/content_icons/cambodia.svg": "715eed39876d0948dba2c39bb845b0d9",
"assets/assets/content_icons/swift.svg": "be5dd307bbe29e1c750801ad8e574474",
"assets/assets/content_icons/biography.svg": "45a8b869b90ace2d16f25163e32afcfd",
"assets/assets/content_icons/maths.svg": "c70958153f060a5e214cf1e8998ae1df",
"assets/assets/content_icons/os.svg": "d395d5e5d7877eff4c2bba3c72c3b202",
"assets/assets/content_icons/cli.svg": "7862a1fb842db7d3168f4d67cd6ba0e8",
"assets/assets/content_icons/general.svg": "0eae05b54c765c8685a71b5f9bb8e1b5",
"assets/assets/content_icons/logo.svg": "7856a5c00bbcba35c054b541b3c02a4f",
"assets/assets/content_icons/kotlin.svg": "bb1050a2565113f9b4a196aef5418fa2",
"assets/assets/content_icons/database.svg": "ae02a4b16b962817ec9af8978bc850cf",
"assets/assets/content_icons/tool.svg": "73384791b0409272fde44e1f25710589",
"assets/assets/content_icons/ios.svg": "1054f6024421fa65f78113b60f0c0277",
"assets/assets/autogen_meta/data_content.json": "60557efaf44b2fbf87cd674f3404ab50",
"assets/assets/tool_icons/calculator.svg": "e21b1347dd2c810546ef6ecbbf6e4cb7",
"assets/assets/tool_icons/camera.svg": "f42876ed16cc9e9137142675c5ad4b55",
"assets/assets/tool_icons/http.svg": "c51c16a6bd5185f37ccde7286a5bd1ad",
"assets/assets/tool_icons/text_editor.svg": "57bb8fa1bc67d1be479ccf3f140b42ae",
"assets/assets/tool_icons/qrcode.svg": "18c6620db4cf0db41019c1ee15d76ec6",
"assets/FontManifest.json": "cf3c681641169319e61b61bd0277378f",
"assets/fonts/MaterialIcons-Regular.otf": "affc7977ab89e6295938b7f8aed25e27",
"assets/AssetManifest.bin.json": "0a811b9641cab45f6508cf10beab4d66",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"favicon.svg": "d40c0a60453bb2bb888455a589fe5316",
"main.dart.js": "4f2b502ecf2c9aa6895f1f7853d34b86",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"manifest.json": "d56f8fa717cc242cee960da48cc7f322",
"version.json": "a07d8bd594cce6033c300d9d89d41de4"};
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
