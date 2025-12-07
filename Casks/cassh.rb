cask "cassh" do
  version "1.0.0"
  sha256 "5a88096fb6e3bdcca5c1a3761f87b3b3b3768d95e5bcd91389cdbc660c3eafdf"

  url "https://github.com/shawntz/cassh/releases/download/v#{version}/cassh-#{version}.pkg"
  name "cassh"
  desc "SSH Key & Certificate Manager for GitHub"
  homepage "https://github.com/shawntz/cassh"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  # PKG installer handles LaunchAgent setup via postinstall script
  pkg "cassh-#{version}.pkg"

  uninstall launchctl: "com.shawnschwartz.cassh",
            pkgutil:   "com.shawnschwartz.cassh",
            delete:    "/Applications/cassh.app"

  zap trash: [
    "~/Library/Application Support/cassh",
    "~/Library/Preferences/com.shawnschwartz.cassh.plist",
    "~/Library/LaunchAgents/com.shawnschwartz.cassh.plist",
    "~/.ssh/cassh_*",
  ]

  caveats <<~EOS
    cassh requires the GitHub CLI for personal account SSH key management:
      brew install gh
      gh auth login

    For enterprise certificate management, configure your cassh server URL.

    The app will appear in your menu bar after first launch.
  EOS
end
