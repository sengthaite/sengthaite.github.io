'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "a07d8bd594cce6033c300d9d89d41de4",
"index.html": "b01058da9cb43ab129c1e03250d7cbff",
"/": "b01058da9cb43ab129c1e03250d7cbff",
"main.dart.js": "264acfdba4e7c50e08d113942c005126",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "fea8cd51eb20cd678e9be54a0c7a496f",
"assets/AssetManifest.json": "de731e8741cdd39da3b4640a21b33c16",
"assets/NOTICES": "b7217178cab6e6fbc0361d795b7c4ad5",
"assets/FontManifest.json": "1b1e7812d9eb9f666db8444d7dde1b20",
"assets/AssetManifest.bin.json": "ffaf42f5d89f4f020a5b3236d377400b",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "36857f315449cf540e1732eff3be29e7",
"assets/fonts/MaterialIcons-Regular.otf": "74b99f0a1e9caadcad9381d412a30de0",
"assets/assets/contents/database/2023-02-10-database-useful-link.markdown": "f63f7a50f4e7f9fac283b6cbffb9ca92",
"assets/assets/contents/database/2023-10-19-sql-fundamental.markdown": "2da071cc9f4ba6533d3a5ff18e09d818",
"assets/assets/contents/tools/2024-02-11-developer-cli-tools.markdown": "cb19edfc4956675d4b4e6c41d3888be8",
"assets/assets/contents/termux/2022-12-11-ssh-to-termux-via-usb.markdown": "7128bf5324d277fb175317a24ec6c5b6",
"assets/assets/contents/general/2023-03-14-pho.markdown": "5ca8b2027eb741200fd160f4b590f176",
"assets/assets/contents/general/2023-03-15-coffee.markdown": "6ddd892bdf1a3a57f6172846e7985b16",
"assets/assets/contents/general/2023-03-09-chrome-without-security-enable.markdown": "b02e5c86d3c3d2d5471041ad53d17644",
"assets/assets/contents/general/2023-03-14-khmer-keyboard-in-mac.markdown": "a931f90106af9def67222069b9183db8",
"assets/assets/contents/general/2022-09-22-solid_principles.markdown": "cc2f2ef80c63f1a8b819520974b24ff3",
"assets/assets/contents/general/2023-04-25-banana.markdown": "abc55c2deb2b37e5ec0d7d8ebb642df9",
"assets/assets/contents/general/2023-03-13-tea.markdown": "79125956360f99a9f6ee2e3e5cbc2d6c",
"assets/assets/contents/general/2023-06-16-coconut.markdown": "43a5ae747566a5ac5623a2762b7fe999",
"assets/assets/contents/general/2023-04-13-tmux.markdown": "8df9a59d47ec4b7bd9c9200eb4529193",
"assets/assets/contents/general/2023-02-03-khmer-proverb.markdown": "57fde2f7aa2ad688292c7ffd40247fbd",
"assets/assets/contents/general/2023-03-31-money.markdown": "f68ce9faa6d1e75241d0e2695492d3b3",
"assets/assets/contents/general/2023-04-11-milk.markdown": "09f56a1be884b0e59823512dd7cfa1ce",
"assets/assets/contents/general/2023-03-20-alan-turing.markdown": "b25e7c0206a1ad2e9421074786ec06fe",
"assets/assets/contents/general/2024-02-16-durian.markdown": "fb880698fb3da08c2c0b6c531911cec9",
"assets/assets/contents/general/2022-12-08-nginx-mac-homebrew.markdown": "3397c2c0d985230b6f9ac883488eb50c",
"assets/assets/contents/general/2023-03-18-citrus.markdown": "8fee5fee468caeaa08b8b457633685a9",
"assets/assets/contents/general/2023-02-27-common-regex.markdown": "22ba5452c12c5720d577697afd5cb8e4",
"assets/assets/contents/general/2023-03-23-sustainable-development-goals.markdown": "83df627ab0677743337c5db070fc171b",
"assets/assets/contents/general/2023-06-06-some-quotes.markdown": "3f28b9ec6e3ff81463c53d72447a8a95",
"assets/assets/contents/general/2023-11-18-client-app-common-features.markdown": "ff7af32ab7bd224211d76a831321958a",
"assets/assets/contents/general/2023-03-22-avocado.markdown": "2b3e59f05988ec2be1c2e6afa2e70343",
"assets/assets/contents/general/2023-03-21-blood.markdown": "49cf16d76c6f38593100cd8f8f7bb3dc",
"assets/assets/contents/general/2023-03-16-garlic.markdown": "6c2768869969d75f9d7c33b253a9041e",
"assets/assets/contents/general/2023-05-28-recover-file-mac.markdown": "a74e4a9dd42e13e6b8b90999da0ddfbb",
"assets/assets/contents/general/2022-11-18-programming-challenges.markdown": "eb9ad23126c03e5c53dfc6da7d1fe6d3",
"assets/assets/contents/general/2023-04-11-find-phone-number-cambodia.markdown": "f7e8c7cf3273c0016921401bd39d63dc",
"assets/assets/contents/general/2023-03-17-soy-source.markdown": "04b5905c02052605489e679ac0e12cc1",
"assets/assets/contents/general/2023-03-19-wikimedia-foundation.markdown": "ce952356ca36154367bbc10c777a95c0",
"assets/assets/contents/llvm/2023-05-07-the-c-programming-exercises.markdown": "28b6bec1457d93f4734c795aeca0eea2",
"assets/assets/contents/angular/2023-02-07-angular-useful-link.markdown": "79cbe1572f7d1cd61c73c1755214e862",
"assets/assets/contents/angular/2022-10-18-common-angular.markdown": "8a3d4d6a548b64f59f10c2bd368ea1fc",
"assets/assets/contents/angular/2022-12-08-angular-base-url.markdown": "677c2d73ae32f55cf0386d45c9138a0c",
"assets/assets/contents/reverse_engineer/2022-12-04-reverse-engineer-roadmap.markdown": "a5a0be46bad8f1074965524757e3fe21",
"assets/assets/contents/ios/2023-01-27-ios_projects.markdown": "aeed19ac463c83d42a3121c300832e3a",
"assets/assets/contents/ios/2023-03-5-ios-dev-topics.markdown": "77d5ca6d76c69488f4994a2242f3b07a",
"assets/assets/contents/ios/2022-12-02-ios-dev-roadmap.markdown": "35c64d022e1b8bfac0a1f13789b918ba",
"assets/assets/contents/ios/2023-12-06-list-ios-app-bundleid.markdown": "4db1f10cbcc0d148495aaa0bae868be2",
"assets/assets/contents/swift/2023-02-14-useful-link-swift.markdown": "b0e06d24cc331a272893d952895272b3",
"assets/assets/contents/swift/2022-09-7-operators.markdown": "7d84bb0a1c5b84450587935c3ba94be0",
"assets/assets/contents/swift/2022-10-15-swift-general-information.markdown": "bf216d55db686e19de3438aa53f98d8b",
"assets/assets/contents/swift/2022-10-08-platforms-learning-swift.markdown": "6bd5b5ee49cc63e390c0b15cee4a3226",
"assets/assets/contents/swift/2022-10-09-basic-swift.markdown": "b182bd90120ff45a134b7a0e8c5e09d2",
"assets/assets/contents/android/android-dev-roadmap.markdown": "1fbbfdd6cb29d9c2589ac9a55a9be811",
"assets/assets/contents/android/2023-02-01-basic-kotlin.markdown": "7c604bd569c730c6589430dcb872b16e",
"assets/assets/contents/android/2023-02-22-android-questions.markdown": "83ddea29ab2970916e83b83dc962e306",
"assets/assets/contents/android/2023-02-21-android-projects.markdown": "473b854a02960e9150facc7a17bb8c49",
"assets/assets/contents/android/2023-02-09-android-studio-features.markdown": "ccc7688a81fb3598795c2c6352bb0b1b",
"assets/assets/contents/android/2023-02-09-kotlin-learning-links.markdown": "94209b94d1ff9c1b54843d5a944514a2",
"assets/assets/contents/c%2523/2023-09-05-dotnet_learning_resources.markdown": "0cf3aa4d44b3a6ac4029c370ae470df4",
"assets/assets/contents/c%2523/2023-09-06-dotnet-webapi.markdown": "f2fd1e00c2d57702da35c75df7bf350b",
"assets/assets/contents/c%2523/2023-09-05-c%2523_keywords.markdown": "c861233cd24fddc496a5e8b6a1d24b55",
"assets/assets/contents/os/2022-12-02-minix-kernel-roadmap.markdown": "f77b30695ac4f933e28e01359a26278e",
"assets/assets/autogen_meta/data.json": "021229f5bee7aaa91c71a3857951e66a",
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
