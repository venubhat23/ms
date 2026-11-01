// Installs the site as an app and shows an offline page when the network is
// down. Pages are deliberately never cached: they carry per-user data, and
// prices/stock must always be live. Fingerprinted assets already get a
// one-year HTTP cache, so they need nothing extra here.
const CACHE = "ms-app-v1"
const OFFLINE_URL = "/offline.html"

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE).then((cache) => cache.add(new Request(OFFLINE_URL, { cache: "reload" })))
  )
  self.skipWaiting()
})

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((key) => key !== CACHE).map((key) => caches.delete(key))))
      .then(() => self.clients.claim())
  )
})

self.addEventListener("fetch", (event) => {
  if (event.request.mode !== "navigate") return

  event.respondWith(fetch(event.request).catch(() => caches.match(OFFLINE_URL)))
})
