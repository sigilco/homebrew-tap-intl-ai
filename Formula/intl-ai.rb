# This formula is generated and updated by the intl-ai release workflow.
# Do not edit manually; changes will be overwritten.

class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.pages.dev"
  license "MIT"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-darwin-arm64"
      sha256 "08df735b31fe25790141791625c5115913ef39635af23af9d47d509a2d1673e9" # populated by CI on release
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-x64"
      sha256 "d7cb30f174d6ed5f38859d9ab8283199e849479d1904e6310778311389978666" # populated by CI on release
    end

    on_arm do
      url "https://github.com/sigilco/intl-ai/releases/download/v#{version}/intl-ai-bun-linux-arm64"
      sha256 "eb474aace20203222af2ac3546e0f43bb50e9ad7216f90a98a399292b16c8151" # populated by CI on release
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
