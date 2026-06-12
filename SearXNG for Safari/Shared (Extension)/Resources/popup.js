const urlInput = document.getElementById("url");
const enabledInput = document.getElementById("enabled");
const status = document.getElementById("status");

browser.storage.local
  .get({ searxngUrl: "", enabled: true })
  .then(({ searxngUrl, enabled }) => {
    urlInput.value = searxngUrl;
    enabledInput.checked = enabled;
  });

document.getElementById("save").addEventListener("click", async () => {
  const raw = urlInput.value.trim();
  if (raw) {
    let parsed;
    try {
      parsed = new URL(raw);
    } catch {
      status.textContent = "Invalid URL";
      status.className = "err";
      return;
    }
    if (parsed.protocol !== "http:" && parsed.protocol !== "https:") {
      status.textContent = "URL must start with http:// or https://";
      status.className = "err";
      return;
    }
  }
  await browser.storage.local.set({
    searxngUrl: raw,
    enabled: enabledInput.checked
  });
  status.textContent = "Saved ✓";
  status.className = "ok";
  setTimeout(() => (status.textContent = ""), 2000);
});
