cask "velquo" do
  version "1.3.1"
  sha256 "4fc1de9203ec52adeed98a70fa25fd4c41f39a740d148fc70883c7ff1cdfa30d"

  url "https://github.com/vsnthdev/Velquo/releases/download/v#{version}/Velquo_#{version}_aarch64.dmg"
  name "Velquo"
  desc "Native Apple Silicon client for KDE Connect"
  homepage "https://github.com/vsnthdev/Velquo"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Velquo.app"

  postflight_steps do
    mkdir_p "Library/Application Support/dev.vsnth.velquo", base: :home
    touch "Library/Application Support/dev.vsnth.velquo/HomebrewInstall", base: :home
  end

  uninstall_postflight_steps do
    remove "Library/Application Support/dev.vsnth.velquo/HomebrewInstall", base: :home
  end

  uninstall quit: "dev.vsnth.velquo"

  zap launchctl: "Velquo",
      trash:     [
        "~/Library/Application Support/dev.vsnth.velquo",
        "~/Library/Caches/dev.vsnth.velquo",
        "~/Library/LaunchAgents/Velquo.plist",
        "~/Library/Logs/Velquo",
        "~/Library/Preferences/dev.vsnth.velquo.plist",
        "~/Library/Saved Application State/dev.vsnth.velquo.savedState",
        "~/Library/WebKit/dev.vsnth.velquo",
      ]

  caveats <<~EOS
    If Velquo is blocked by macOS Gatekeeper on first launch, run:
      xattr -cr /Applications/Velquo.app
  EOS
end
