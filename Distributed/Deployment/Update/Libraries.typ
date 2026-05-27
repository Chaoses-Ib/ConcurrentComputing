#import "@local/ib:0.1.0": *
#title[Software Update Libraries]
- #a[ib-update: A lightweight software update library.][https://github.com/Chaoses-Ib/IbUpdateLib]

- #a[WinSparkle][https://winsparkle.org/]
  #a-badge[https://github.com/vslavik/winsparkle]
  - Server: #a[Appcast Feeds][https://github.com/vslavik/winsparkle/wiki/Appcast-Feeds]
  - Rust
    - #a[hankbao/sparkle-updater: A Rust crate that allows you to add automatic software updates to your macOS and Windows applications.][https://github.com/hankbao/sparkle-updater]

= Rust
#footnote[#a[Is there a way to make an app update itself remotely. : r/rust][https://www.reddit.com/r/rust/comments/1aqvl2b/is_there_a_way_to_make_an_app_update_itself/]]
#footnote[#a[How self-update a terminal app on linux/windows with rust? : r/rust][https://www.reddit.com/r/rust/comments/esgmde/how_selfupdate_a_terminal_app_on_linuxwindows/]]

- #a[`self_update`: Self updates for rust executables][https://github.com/jaemk/self_update]
  #footnote[#a[`self_update`: In-place updates for rust executables : r/rust][https://www.reddit.com/r/rust/comments/6pxw0n/self_update_inplace_updates_for_rust_executables/]]
  (inactive)
  - Server: GitHub, GitLab, Gitea, S3
    - #a[Can you add support for china's gitee ? - Issue \#121][https://github.com/jaemk/self_update/issues/121]
  - #a[`semver`][https://github.com/dtolnay/semver]
    - #a[Support pre-release versions - Issue \#61][https://github.com/jaemk/self_update/issues/61]
  - #a[`self-replace`][https://github.com/mitsuhiko/self-replace]
  - Client: Sync, `reqwest` / `ureq`
    - #a[proxy support on windows 10 - Issue \#45][https://github.com/jaemk/self_update/issues/45]

- #a[Tauri Updater][https://v2.tauri.app/plugin/updater/]

- #a[Velopack: Installer and automatic update framework for cross-platform desktop applications][https://github.com/velopack/velopack]
  - Server: FS, GitHub, GitLab, Gitea, HTTP
  - `ureq`

- #a[axodotdev/axoupdater: Updater program for axo tools][https://github.com/axodotdev/axoupdater]
  - Server: GitHub
  - Client: Require `cargo-dist` receipts.

- #a[tangxiangong/release-hub: A simple updater for Rust GUI applications][https://github.com/tangxiangong/release-hub]
  - Server: JSON, GitHub

- #a[danwilliams/patchify: Rust library for automatic self-updating of applications][https://github.com/danwilliams/patchify]
  - Server: Axum

- #a[rednimgames/rose-updater: ROSE Online Updater][https://github.com/rednimgames/rose-updater]

- #a[drogue-iot/embedded-update][https://github.com/drogue-iot/embedded-update]
