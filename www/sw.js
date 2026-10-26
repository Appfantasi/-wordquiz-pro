// Service worker: funziona offline. Il nome della cache cambia ad ogni build (vedi workflow).
// Il prefisso evita di toccare le cache di altre PWA ospitate sullo stesso dominio.
const PREFIX = 'wordquiz-';
const CACHE = 'wordquiz-v1';
const ASSETS = ['./', 'index.html', 'manifest.webmanifest', 'icons/icon-192.png', 'icons/icon-512.png', 'icons/maskable-512.png'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys => Promise.all(keys.filter(k => k.startsWith(PREFIX) && k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET' || !req.url.startsWith(self.registration.scope)) return;
  const store = res => { if (res.ok) { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)); } return res; };
  if (req.mode === 'navigate') {
    // pagina: prima la rete (aggiornamenti subito), se offline la cache
    e.respondWith(fetch(req).then(store).catch(() => caches.open(CACHE).then(c => c.match('index.html'))));
  } else {
    e.respondWith(caches.open(CACHE).then(c => c.match(req)).then(hit => hit || fetch(req).then(store)));
  }
});
