'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "a07d8bd594cce6033c300d9d89d41de4",
"index.html": "aaa396127e62f9dac3d451ce90790d38",
"/": "aaa396127e62f9dac3d451ce90790d38",
"main.dart.js": "6c99d3019daa0a2f33a4efc3b76cda2b",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "fea8cd51eb20cd678e9be54a0c7a496f",
"assets/AssetManifest.json": "ab714deeea4ab25cd5d5ef8b8001fb33",
"assets/NOTICES": "b7217178cab6e6fbc0361d795b7c4ad5",
"assets/FontManifest.json": "1b1e7812d9eb9f666db8444d7dde1b20",
"assets/AssetManifest.bin.json": "11e931aee9f1c1e09ba317390655bf97",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "43c9cbb60ba4a3bc4419917e19fb05c1",
"assets/fonts/MaterialIcons-Regular.otf": "74b99f0a1e9caadcad9381d412a30de0",
"assets/assets/contents/database/sql-fundamental.txt": "f5919d050cad438448cfd28422f3add2",
"assets/assets/contents/database/database-useful-link.txt": "503d271214d4b1ceade3f737ce642afb",
"assets/assets/contents/tools/developer-cli-tools.txt": "34d6618a1b6f58c8717d53adbf61cf17",
"assets/assets/contents/termux/ssh-to-termux-via-usb.txt": "db44ade77ccd35b5a3a6aee82432d42e",
"assets/assets/contents/general/coconut.txt": "6b0676d0f084c93c098e81b968bb34e4",
"assets/assets/contents/general/soy-source.txt": "a45589206daad47fda9f9e7759344313",
"assets/assets/contents/general/nginx-mac-homebrew.txt": "ced6fd10f0937edf56e8a797db23b726",
"assets/assets/contents/general/alan-turing.txt": "2be97c31f2d6a07d37841af563fbe6b6",
"assets/assets/contents/general/chrome-without-security-enable.txt": "5e33611127465775867f9e6679b39386",
"assets/assets/contents/general/milk.txt": "faaf886c20e111d962cea52611538b22",
"assets/assets/contents/general/blood.txt": "7dba09e574be6e6c4bf5e18f7fe613da",
"assets/assets/contents/general/find-phone-number-cambodia.txt": "2981a9449acb13593caae6bf89055d56",
"assets/assets/contents/general/solid_principles.txt": "595a8ad2a6f977d31a14a7f0c7f1c8f3",
"assets/assets/contents/general/programming-challenges.txt": "3fad2fa7eb94fa964a5f7d2d2cbbfbed",
"assets/assets/contents/general/coffee.txt": "bccc291bb8e51fec050df4405626eee1",
"assets/assets/contents/general/pho.txt": "f1873def82bc55135a10ae032d883744",
"assets/assets/contents/general/durian.txt": "9c53c70c855cf1cd4fd28264003037db",
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
"assets/assets/contents/general/avocado.txt": "2c0276818f17425ccb31b74a89388555",
"assets/assets/contents/general/wikimedia-foundation.txt": "c07e6282723918043b20fbaa7a6aad24",
"assets/assets/contents/llvm/the-c-programming-exercises.txt": "68d771c06047e657cc503eb2dfe638ae",
"assets/assets/contents/angular/common-angular.txt": "5e12ca605b452313c8eedae6786db044",
"assets/assets/contents/angular/angular-useful-link.txt": "b16a74f07f6285c34577c90b6a0a6921",
"assets/assets/contents/angular/angular-base-url.txt": "32aeaa721c4c42be45f0276a31ef53ba",
"assets/assets/contents/reverse_engineer/reverse-engineer-roadmap.txt": "086ff087045bd89596a7da9ca38a214d",
"assets/assets/contents/ios/ios-dev-topics.txt": "ff509ae821f3de720828090534aed933",
"assets/assets/contents/ios/list-ios-app-bundleid.txt": "339a06f931fae627745e5d1ac0d034e8",
"assets/assets/contents/ios/ios-dev-roadmap.txt": "a4e0fbf0962f822ca59073a7875de440",
"assets/assets/contents/ios/ios_projects.txt": "ff0b681ed46c3101efc812589d58934a",
"assets/assets/contents/swift/useful-link-swift.txt": "3f3dec6f437192699958c62f0a43fee2",
"assets/assets/contents/swift/platforms-learning-swift.txt": "a72e23ee5765b7c684ed5bd57ca24d16",
"assets/assets/contents/swift/basic-swift.txt": "1e49d3d4cb03a812b181889b9897fbaa",
"assets/assets/contents/swift/swift-general-information.txt": "e49237f727139b25f66685e7fc496c29",
"assets/assets/contents/swift/operators.txt": "d7eb1bcb780ef3fd7041727d21ed940e",
"assets/assets/contents/android/android-studio-features.txt": "0af2a2227ffb817eb137deab79af03e0",
"assets/assets/contents/android/android-questions.txt": "94d21d6286328f246bb4b512d92243ce",
"assets/assets/contents/android/kotlin-learning-links.txt": "82a9dfaa4a991acdc090898dc5378bb8",
"assets/assets/contents/android/basic-kotlin.txt": "7750fb18d0898578804252dfc1b6ad58",
"assets/assets/contents/android/android-dev-roadmap.txt": "234242edc52b1a9ebba137933411d43e",
"assets/assets/contents/android/android-projects.txt": "c600c16cf034fccaa4e4d69b09856a93",
"assets/assets/contents/c%2523/c%2523_keywords.txt": "01ea05c0cf12fc3b586ba986e9c53df8",
"assets/assets/contents/c%2523/dotnet_learning_resources.txt": "0ae333152ff4538216266cfd30f1edb9",
"assets/assets/contents/os/minix-kernel-roadmap.txt": "c66cba9de1cdb75722d9677c98b4dda3",
"assets/assets/autogen_meta/data.json": "ed102aac4e16102edf027dd9b9a8a4ed",
"assets/assets/icons/maths.png": "ab77528c5696e155c39807929cef6ea8",
"assets/assets/icons/termux.png": "0d6af59a9ba84acb559b7510beb4a12d",
"assets/assets/icons/angular.png": "f198bcdc012bb3cfcca5772787deab75",
"assets/assets/icons/database.png": "221ee653242da6fac87062b674a0132f",
"assets/assets/icons/llvm.png": "88615afd311acee6b3ea19a85eaaa977",
"assets/assets/icons/android.png": "ff177b2e5a7ca46ab266563672a9967c",
"assets/assets/icons/tools.png": "8d40a0c2bbb268aefec015a7a9d93471",
"assets/assets/icons/reverse_engineer.png": "0c51ba99d0457789c0cd15c3e83a16a3",
"assets/assets/icons/logo.png": "fc93c61bbbf837fda3f5794b8b319d8c",
"assets/assets/icons/swift.png": "5d1920a731ddb4529976fb1a067078dd",
"assets/assets/icons/ios.png": "4dbc5148ac04330342c3e9136506b7cc",
"assets/assets/icons/os.png": "f658ddd7e40ae86c1df95b241a3135f7",
"assets/assets/icons/general.png": "e9b6d52ddc008d019031d1bba963c28e",
"assets/assets/icons/c%2523.png": "05567f16405f3c4e5ef0bb67528a0a13",
"assets/assets/icons/kotlin.png": "9601fa97676f1c4d7ab760302f0cf21b",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
