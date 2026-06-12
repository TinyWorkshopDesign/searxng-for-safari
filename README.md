# SearXNG for Safari

Use your own [SearXNG](https://github.com/searxng/searxng) instance as Safari's search engine — on macOS, iOS, and iPadOS.

Safari doesn't allow custom search engines, so this Safari Web Extension takes the same approach as apps like Braver Search: you set **DuckDuckGo** as Safari's search engine, and the extension instantly redirects every search to your SearXNG instance before the DuckDuckGo page even loads.

## Features

- Configurable instance URL — change it anytime from the extension popup
- Enable/disable toggle
- No tracking, no analytics, no network requests of its own — it only rewrites the search URL locally

## Requirements

- macOS 11+ / iOS 15+ with Safari
- Xcode (to build)
- A SearXNG instance (self-hosted or any instance you trust)

## Build & install (macOS)

```sh
git clone https://github.com/TinyWorkshopDesign/searxng-for-safari.git
cd searxng-for-safari/"SearXNG for Safari"
xcodebuild -scheme "SearXNG for Safari (macOS)" -configuration Release \
  -derivedDataPath build \
  DEVELOPMENT_TEAM=<YOUR_TEAM_ID> CODE_SIGN_STYLE=Automatic build
cp -R "build/Build/Products/Release/SearXNG for Safari.app" /Applications/
open "/Applications/SearXNG for Safari.app"
```

Alternatively, open `SearXNG for Safari.xcodeproj` in Xcode, select the **SearXNG for Safari (macOS)** scheme, set your signing team, and build.

> Without an Apple Development certificate you can sign ad hoc, but you'll need to enable *Develop → Allow Unsigned Extensions* in Safari on every launch.

## Install (iOS / iPadOS)

1. Open `SearXNG for Safari.xcodeproj` in Xcode
2. Select the **SearXNG for Safari (iOS)** scheme and your connected device
3. Set your signing team and run
4. On the device: Settings → Apps → Safari → Extensions → enable **SearXNG for Safari**

> With a free Apple ID the app signature expires after 7 days; a paid developer account removes this limit.

## Setup

1. **Enable the extension**: Safari → Settings → Extensions → check *SearXNG for Safari*. When asked for permissions on duckduckgo.com, choose **Always Allow on This Website**.
2. **Set your instance URL**: click the extension icon in Safari's toolbar, enter your SearXNG URL (e.g. `https://searx.example.com`), and hit **Save**.
3. **Set DuckDuckGo as the default search engine**: Safari → Settings → Search → Search Engine → DuckDuckGo.

That's it — every search from the address bar now lands on your SearXNG instance.

## How it works

A content script injected at `document_start` on `duckduckgo.com` reads the `q` query parameter, stops the page load, and replaces the location with `<your-instance>/search?q=<query>`. The extension source lives in [`extension/`](extension/); the Xcode project wrapping it was generated with Apple's `safari-web-extension-converter`.

## License

[MIT](LICENSE)
