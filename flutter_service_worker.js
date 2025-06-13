'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"manifest.json": "b2013acf66d9dbac458902c402fadb2b",
"main.dart.js": "ad9bcc935ccd31ead4efee60e8a545c2",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"index.html": "a782203605c5373068b96905987518b0",
"/": "a782203605c5373068b96905987518b0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/AssetManifest.bin.json": "7259e4d23fc5e64d69d8fdde7397a985",
"assets/AssetManifest.bin": "0ea132dddbaa1c030817dfe3c807e20e",
"assets/NOTICES": "55c9a309f15274b9803bd808f6404548",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/cogo_logo.svg": "f7926c0e3493b5b17d8d72f73209c75c",
"assets/assets/default_img.png": "f47fe390e80d33925a80cdd44128a2e1",
"assets/assets/image/img_apple_login.svg": "88dd5d0671d91f3b8ead5e0744df14b2",
"assets/assets/image/img_image.svg": "42bf64ffe59d034cdd6954fff2e1a079",
"assets/assets/image/img_google_login.svg": "0bcfbacceed53daa0a3499eddec4a8e1",
"assets/assets/image/logo.svg": "ad397bbdf50a3cfbdd48f5f9804f6fc5",
"assets/assets/lottie/intro.json": "64f991a2f03f31b1a40d01bb370bf395",
"assets/assets/icons/button/check.svg": "0df854715457179b068ae747fdf10b2c",
"assets/assets/icons/button/uncheck.svg": "8f5786c1283909fe24050490e0af96dc",
"assets/assets/icons/button/chevron_left.svg": "a137cf8baf99cfb95ba43af3ac29ce39",
"assets/assets/icons/button/search.svg": "24a17d6366a8f0295333abe639fed45f",
"assets/assets/icons/button/close.svg": "edf54d5836344f3a4a805a3ce889a44d",
"assets/assets/icons/button/glyph.svg": "63661f05fbe6600750a0842e5ca66001",
"assets/assets/icons/navigator/home.png": "e6e8ad40cafe6c8fcb427fdd5fdc252d",
"assets/assets/icons/navigator/cogo.png": "1cd31471b5b96f43fca9e5926a54bfc9",
"assets/assets/icons/navigator/cogo.svg": "742111ac2e5d24f45ed0d80f06609ba6",
"assets/assets/icons/navigator/mypage.png": "72c2259705d2e6118129fbfbbad65116",
"assets/assets/icons/navigator/mypage.svg": "ad451660b30fd70e6f04c47e4e9d1c6b",
"assets/assets/icons/navigator/home.svg": "d9d9a158bcc8c496cb441c6e127dea89",
"assets/assets/icons/3d_img/calendar.png": "aa434e806eed7a2c07376f1144608488",
"assets/assets/icons/3d_img/empty.png": "d0edda8c4c494019852edb0984113d0e",
"assets/assets/icons/3d_img/trash.png": "a56290997ae5bca130537208bce3793d",
"assets/assets/icons/3d_img/caution.png": "acb5c6a96fa5ffb4e86f430d5f6e5737",
"assets/assets/icons/3d_img/coffee.png": "aff3973aba26a19cb8394748c67cc894",
"assets/assets/icons/3d_img/fire.png": "e487af2229d83b50d9fcaabba98c4d32",
"assets/assets/icons/3d_img/heart.png": "16e0c86b9e4bb0116883dedca7d113f3",
"assets/assets/raccoonimg.png": "61c694400989004dc39a6c6c56c31511",
"assets/assets/fonts/Pretendard-Medium.ttf": "6d045f83b15a4ce0108df8e96e53851e",
"assets/assets/fonts/Pretendard-Bold.ttf": "0e31c423b3971eecd79d2866b8ad65ac",
"assets/assets/fonts/Pretendard-SemiBold.ttf": "52e17b18a3a47c23bcdd626a3d8f163c",
"assets/assets/fonts/Pretendard-Light.ttf": "1a9b52d0674840d80e8a60dd1270114f",
"assets/assets/fonts/Pretendard-Regular.ttf": "f9574625d71019a3d7d8417e9ac35e7e",
"assets/AssetManifest.json": "3c2ad6d0b4a98ac98ac8472c56a2f895",
"assets/fonts/MaterialIcons-Regular.otf": "aa9b3d238180a6b5697ab03e21818a48",
"assets/FontManifest.json": "e74c04a551ef5b45ca04d1768657130c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"flutter_bootstrap.js": "b9ad12255e72524194df5679c039cf39",
"version.json": "fcb8e206b45f08267e998b42aa61ad93"};
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
