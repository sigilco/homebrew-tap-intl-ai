# This formula is generated and updated by the intl-ai release workflow.
# Do not edit manually; changes will be overwritten.

class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.pages.dev"
  license "MIT"
  version "0.4.1"

  on_macos do
    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-darwin-arm64"
      sha256 "fc535cb9d368bb2e1bb70a069eab2e7f5b3057eff8dfca18e4a5cb42f49bcab2" # populated by CI on release
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-x64"
      sha256 "f1bcb4ba8c6c13b1f75ceaa7a81607d4387a47540e31158962440d267bf2ebd0" # populated by CI on release
    end

    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-arm64"
      sha256 "7416ea08395568ee9da79846c9f2ecb77e7e403a593defb79d44d482c2eb6bb6" # populated by CI on release
    end
  end

  def install
    if Hardware::CPU.arm? && OS.mac?
      bin.install "intl-ai-bun-darwin-arm64" => "intl-ai"
    elsif Hardware::CPU.intel? && OS.linux?
      bin.install "intl-ai-bun-linux-x64" => "intl-ai"
    elsif Hardware::CPU.arm? && OS.linux?
      bin.install "intl-ai-bun-linux-arm64" => "intl-ai"
    end
  end

  test do
    system "#{bin}/intl-ai", "--version"
  end
end
