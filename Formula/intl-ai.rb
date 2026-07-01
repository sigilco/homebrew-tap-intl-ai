# This formula is generated and updated by the intl-ai release workflow.
# Do not edit manually; changes will be overwritten.

class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.pages.dev"
  license "MIT"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-darwin-arm64"
      sha256 "e4e8002ed2ff26c8aaed9869acd4d00769040208f1fb3fe385f283d5faff7e87" # populated by CI on release
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-x64"
      sha256 "6540650eb2c06357c1d61e86f61d42e974e489624fc2d07b84bad88f339b29bd" # populated by CI on release
    end

    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-arm64"
      sha256 "e61d10a378277b0196b172f8873e217787af924c34a750d01d2a72f9c73ae88f" # populated by CI on release
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
