'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "app-ads.txt": "7f207ebd168be09c4b83b7085d8d8169",
"assets/AssetManifest.json": "1da96d6eb66fa7c7b44bfbbf2a5eb0d5",
"assets/assets/images/add_photo.png": "f509b7e0f3935e992cded087e0b8d4ce",
"assets/assets/images/appdark.jpeg": "050860ce348bcfbfe0453dd22735d68d",
"assets/assets/images/appLight.jpeg": "a1bddc2a4dae1035270eee3fcd06ebe8",
"assets/assets/images/AuthenticationBG.jpg": "5934443c72451642cae73ca8bab4d78a",
"assets/assets/images/bookmark.png": "cf30250c73a2bec56203208623dff61d",
"assets/assets/images/bookmarkfilled.png": "cdcadfed6e238b61ba8f11c2cb592f32",
"assets/assets/images/Brazucabrowsing.png": "48ae4a10d64a860705b32bb76be9c2a9",
"assets/assets/images/Chat.png": "a858d68eda876227523cd334009224cc",
"assets/assets/images/Chat2.png": "b4adf4f7feabb4c1dde5d01835f19658",
"assets/assets/images/Chatoutline1.png": "328d25b657a5842131b6ecdb656614c8",
"assets/assets/images/Cittpartytime.png": "30579530b4b3f9ec22bf70c875700059",
"assets/assets/images/Dayflowbestfriends.png": "261badcbb0c56a91692bdbeb65043839",
"assets/assets/images/Diamond2.png": "77abe8b204e5971a53b0f9e1f45005d3",
"assets/assets/images/Diamondcare.png": "88aac5691b5f8a872749a42e2df6b6c4",
"assets/assets/images/Diamondoutline1.png": "5c39c192238edb87ba6d6dac0cc302d9",
"assets/assets/images/edit.png": "dc41f52242d3c2afd6403ce4309a6eec",
"assets/assets/images/facebookIcon.png": "476066ed78e688659dd7e5edec04a641",
"assets/assets/images/Forwardarrow.png": "434031ae4723b37d0d3c5ed2cd421e08",
"assets/assets/images/Happybunchastronaut.png": "ce0f9a32e7c1c6c9a1dd85e9999b5c81",
"assets/assets/images/Hobbieshobbiesfill.png": "5fe1054598fcd6f7d5295f817d12ad46",
"assets/assets/images/HumanCharacters.png": "4adf23a459df8d03140b596e6a72a498",
"assets/assets/images/icon_chat.png": "e4553fac107350338d2481ef3a0e4f9e",
"assets/assets/images/icon_eye.png": "1be875cf174ff357a5d95928523fa839",
"assets/assets/images/icon_heart_filled.png": "8b482a2cc9a3efadef3ef0597a90124b",
"assets/assets/images/icon_heart_outline.png": "b1b08f08855757ae279ca3dc62e498c4",
"assets/assets/images/icon_new_bookmark.png": "c3189b9d6ee2ab0c7d4b1e5cff07b329",
"assets/assets/images/icon_new_bookmark_filled.png": "b04b0c076c8d5e735f00a3afaf3fb06d",
"assets/assets/images/icon_new_chat.png": "4df31cda7d968bb72c218fcc6063adb6",
"assets/assets/images/icon_new_share.png": "b7751d7c8b8d23f1931f7d6d2d0e8db6",
"assets/assets/images/instagram.png": "c0044cf5967e29c12b6c9416f963232b",
"assets/assets/images/instagramIcon.png": "a621753dda7dc0de0acd239a748251ec",
"assets/assets/images/journzlogo1.png": "9411c128e410238c0f7689b553104ae2",
"assets/assets/images/journzLogoFigma.png": "77e798fa9db93b6fc9133e8252cc6fe3",
"assets/assets/images/journzpng2.png": "78e63161e3986d6cd0bc0ba50af7b5a1",
"assets/assets/images/LikeEmoji.png": "68e8eb083b499690ab2d747e84a6c6a5",
"assets/assets/images/linkedinIcon.png": "968ea62882943e88bbd318ae5fa67429",
"assets/assets/images/login.jpeg": "9418fe5f2e1f15460cbb7cf141782e75",
"assets/assets/images/logo.png": "9411c128e410238c0f7689b553104ae2",
"assets/assets/images/namelogo.png": "7c2c6cf208c2726d8ba3ed89e63b8db5",
"assets/assets/images/newlogo.png": "7c2c6cf208c2726d8ba3ed89e63b8db5",
"assets/assets/images/Okay2.png": "d033dec5519438d3b0691b82e792fd28",
"assets/assets/images/Okayoutline1.png": "fa56bcfafb0552a234a07f3465d45aac",
"assets/assets/images/Olgardeningtogether.png": "f5a37f0c7b8b0f3a21243a084b7f90bb",
"assets/assets/images/profile1.jpg": "bcd57a1d54d983ec68122ff229ddf5ba",
"assets/assets/images/Sharefilled2.png": "8ac60a95492bb2e054bd3deaefd81ca3",
"assets/assets/images/Shareoutline1.png": "711c458a7c1810b97d84fcf42e94c9c3",
"assets/assets/images/Shopaholicsseller.png": "40435fa701be6b481ed3b7163b319981",
"assets/assets/images/signupBg.jpeg": "2c962c1f2e88434bda8f44cec5c5e5c7",
"assets/assets/images/socialMedia.png": "1d8597e7231c31834c6f37925d6f1ba8",
"assets/assets/images/Stuckathomestatsandgraphs.png": "a8b56c27ac486f1c9b6b57d69a7d2752",
"assets/assets/images/Thebandband.png": "a9929d8874fbcb558f6020f0f78f5c08",
"assets/assets/images/twitterIcon.png": "b0e34da845c0b106a91a330c028538f2",
"assets/assets/images/verifyEmail.png": "015359cb2761f4f31829cb778cf01c44",
"assets/assets/images/ViewsEmoji.png": "215f636b1923524e9d0e67d71b9d0ce4",
"assets/assets/images/Wonderlearnersartclass.png": "73abb9d1e5bf65b32a34b15624d76789",
"assets/assets/images/Yuppiessuperidea.png": "a858c2e2c5bfa6bc64967e7939e44daa",
"assets/FontManifest.json": "3ba95e877e8d977ed295b7a8efefeff7",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "ccb8af242d38c7bc46d4e823050727ca",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/html_editor_enhanced/assets/font/summernote.eot": "f4a47ce92c02ef70fc848508f4cec94a",
"assets/packages/html_editor_enhanced/assets/font/summernote.ttf": "82fa597f29de41cd41a7c402bcf09ba5",
"assets/packages/html_editor_enhanced/assets/font/summernote.woff": "c1a96d26d30d9e0b2fd33c080d88c72e",
"assets/packages/html_editor_enhanced/assets/font/summernote.woff2": "f694db69cded200e4edd999fddef81b7",
"assets/packages/html_editor_enhanced/assets/jquery.min.js": "b61aa6e2d68d21b3546b5b418bf0e9c3",
"assets/packages/html_editor_enhanced/assets/plugins/summernote-at-mention/summernote-at-mention.js": "8d1a7c753cf1a4cd0058e31fa1e5376e",
"assets/packages/html_editor_enhanced/assets/summernote-lite-dark.css": "3f3cb618d1d51e3e6d0d4cce469b991b",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.css": "cadfcf986f26d830521e9a63350f4dbd",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.js": "4fe75f9b35f43da141d60d6a697db1c1",
"assets/packages/html_editor_enhanced/assets/summernote-no-plugins.html": "89ca56cd85a91f1dc39f5413204e24d0",
"assets/packages/html_editor_enhanced/assets/summernote.html": "8ce8915ee5696d3c568e94911eb0d9bf",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.ico": "a87fc78815b101a2f8250c92bddbf6a6",
"firebase-config.js": "0cafac72f4eb54f75b0722d2499f182c",
"icons/icon-192.png": "cb17fdd74d5a077325ecc884e4842a79",
"icons/icon-512.png": "cb17fdd74d5a077325ecc884e4842a79",
"icons/Icon-maskable-192.png": "cb17fdd74d5a077325ecc884e4842a79",
"icons/Icon-maskable-512.png": "cb17fdd74d5a077325ecc884e4842a79",
"index.html": "5b90b81eff0eab53f273ae250542a951",
"/": "5b90b81eff0eab53f273ae250542a951",
"main.dart.js": "1fb8844d2af592bc37b37ad3c6afd110",
"manifest.json": "1e7f926d1ce6d4b7a406f34949bd7100",
"version.json": "9deb5c2333c006b7e4e5a38a2738c90b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
