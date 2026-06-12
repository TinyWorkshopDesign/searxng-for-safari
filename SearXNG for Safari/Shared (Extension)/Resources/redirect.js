(async () => {
  const params = new URLSearchParams(location.search);
  const q = params.get("q");
  if (!q) return;

  const { searxngUrl, enabled } = await browser.storage.local.get({
    searxngUrl: "",
    enabled: true
  });
  if (!enabled || !searxngUrl) return;

  const base = searxngUrl.replace(/\/+$/, "");
  window.stop();
  location.replace(`${base}/search?q=${encodeURIComponent(q)}`);
})();
