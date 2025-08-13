'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "69ab328d124d9b1ccf475f958663e84b",
"version.json": "a07d8bd594cce6033c300d9d89d41de4",
"index.html": "f7bf9dec00b417d3e9b582fab0d61b26",
"/": "f7bf9dec00b417d3e9b582fab0d61b26",
"main.dart.js": "5692ae5e997c080ade9e4a2dca65e2ab",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.mjs": "72eb4b2a1670df8936faa61d1a12a76c",
"icons/Icon-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"icons/Icon-maskable-192.png": "e66d6bdfd9c8eac2471d5837a47f942f",
"icons/logo.png": "73d403cbbf73def2aa538fc9dad69b65",
"icons/Icon-maskable-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"icons/Icon-512.png": "1fb9f1b1a342225d47358b77ea81808d",
"manifest.json": "d56f8fa717cc242cee960da48cc7f322",
"main.dart.wasm": "6f400791b03c242712540bb37cbe7ef5",
"assets/AssetManifest.json": "9c255b46c2bd6c3ddbbbadfda155be2c",
"assets/NOTICES": "cd84bef6f712fac545a600c2c3c2ea78",
"assets/FontManifest.json": "456b4eb49bce64dfd3824cbfe3df7f35",
"assets/AssetManifest.bin.json": "84b452c73d9736ec5ceed1d84267519b",
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
"assets/packages/quill_native_bridge_linux/assets/xclip": "d37b0dbbc8341839cde83d351f96279e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "8b881d29041ec1ca0b7d3a2e269f2764",
"assets/fonts/MaterialIcons-Regular.otf": "417798d79ba27f47526e0982d2caf90f",
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
"assets/assets/contents/Database/sql-fundamental.txt": "6737b34b22c0b14d79b6a983b9ddf63e",
"assets/assets/contents/Database/database-useful-link.txt": "503d271214d4b1ceade3f737ce642afb",
"assets/assets/contents/Biography/krom_ngoy.txt": "20c0eab5ea13b2f2d2e7eff25e2079c8",
"assets/assets/contents/General/coconut.txt": "6b0676d0f084c93c098e81b968bb34e4",
"assets/assets/contents/General/soy-source.txt": "a45589206daad47fda9f9e7759344313",
"assets/assets/contents/General/nginx-mac-homebrew.txt": "ced6fd10f0937edf56e8a797db23b726",
"assets/assets/contents/General/alan-turing.txt": "8fe5ef1938cb9013a148380a1db7eb15",
"assets/assets/contents/General/chrome-without-security-enable.txt": "cb1ceee928e51a8d318077a57ace4b03",
"assets/assets/contents/General/milk.txt": "faaf886c20e111d962cea52611538b22",
"assets/assets/contents/General/blood.txt": "7dba09e574be6e6c4bf5e18f7fe613da",
"assets/assets/contents/General/find-phone-number-cambodia.txt": "2981a9449acb13593caae6bf89055d56",
"assets/assets/contents/General/solid_principles.txt": "dd7ac4ca2ca95eb3987784afdd947c4f",
"assets/assets/contents/General/programming-challenges.txt": "3fad2fa7eb94fa964a5f7d2d2cbbfbed",
"assets/assets/contents/General/coffee.txt": "6c3b4c1cc7f56ca0cd9556ce1d369436",
"assets/assets/contents/General/pho.txt": "f1873def82bc55135a10ae032d883744",
"assets/assets/contents/General/durian.txt": "f0bf803ad42ef95204d71ce5ec98e263",
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
"assets/assets/contents/General/avocado.txt": "ff22631916c74e7a984a3489586eaf33",
"assets/assets/contents/General/wikimedia-foundation.txt": "c07e6282723918043b20fbaa7a6aad24",
"assets/assets/contents/LLVM/the-c-programming-exercises.txt": "68d771c06047e657cc503eb2dfe638ae",
"assets/assets/contents/Angular/common-angular.txt": "f6d33068a02ccd972f20cf09697fb3e5",
"assets/assets/contents/Angular/angular-useful-link.txt": "b16a74f07f6285c34577c90b6a0a6921",
"assets/assets/contents/Angular/angular-base-url.txt": "32aeaa721c4c42be45f0276a31ef53ba",
"assets/assets/contents/CLI/ssh-to-termux-via-usb.txt": "db44ade77ccd35b5a3a6aee82432d42e",
"assets/assets/contents/Reverse_Engineer/reverse-engineer-roadmap.txt": "086ff087045bd89596a7da9ca38a214d",
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
"assets/assets/contents/Android/android-questions.txt": "0d081d2de84fa6cb9b1c3deab76c390c",
"assets/assets/contents/Android/kotlin-learning-links.txt": "82a9dfaa4a991acdc090898dc5378bb8",
"assets/assets/contents/Android/basic-kotlin.txt": "7750fb18d0898578804252dfc1b6ad58",
"assets/assets/contents/Android/android-dev-roadmap.txt": "428dfb61907f711fbb77c0848b2799ea",
"assets/assets/contents/Android/android-projects.txt": "22760a920ede42f1c9baff169701db02",
"assets/assets/contents/C%2523/c%2523_keywords.txt": "01ea05c0cf12fc3b586ba986e9c53df8",
"assets/assets/contents/C%2523/dotnet_learning_resources.txt": "0ae333152ff4538216266cfd30f1edb9",
"assets/assets/contents/OS/minix-kernel-roadmap.txt": "168c6d12e7f8a29d76fd393759f86882",
"assets/assets/contents/Cambodia/name_of_provinces_cambodia.txt": "bced0089510ea7f9b6cd65c746da0562",
"assets/assets/contents/Tool/developer-cli-tools.txt": "34d6618a1b6f58c8717d53adbf61cf17",
"assets/assets/autogen_meta/data_content.json": "312c931ac3df2eeaa4dc09f265b85b80",
"assets/assets/tool_icons/http.svg": "c51c16a6bd5185f37ccde7286a5bd1ad",
"assets/assets/tool_icons/camera.svg": "f42876ed16cc9e9137142675c5ad4b55",
"assets/assets/tool_icons/text_editor.svg": "57bb8fa1bc67d1be479ccf3f140b42ae",
"favicon.svg": "d40c0a60453bb2bb888455a589fe5316",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
