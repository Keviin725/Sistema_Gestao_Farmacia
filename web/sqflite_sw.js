const CACHE_NAME = 'sqflite_cache';
self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(CACHE_NAME));
});

self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
  if (event.request.url.includes('/sqflite')) {
    event.respondWith(caches.match(event.request).then((response) => {
      return response || fetch(event.request).then((response) => {
        let clone = response.clone(); // Clonar a resposta aqui
        caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone)); // Usar o clone aqui
        return response;
      });
    }));
  }
});
