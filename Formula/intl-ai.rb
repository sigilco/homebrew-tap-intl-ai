class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.pages.dev"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.5.0/intl-ai-aarch64-apple-darwin.tar.xz"
      sha256 "f7194a2964b96404d2a0bee1eb02d95368038906dc723a5d00453d8c07012542"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.5.0/intl-ai-x86_64-apple-darwin.tar.xz"
      sha256 "354d552e3ecc0cfa4090614b757132502ab0be82734dba9402e8ca1612a1a594"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.5.0/intl-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "59bbd50c60f1603c435b9008aba9e18997857c99a9cef04e8fb5b3e5432da904"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.5.0/intl-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d188e4c35245d9295835e77d50863102b18edc49a2a46ae4353d43a39e0166d7"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "intl-ai"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "intl-ai"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "intl-ai"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "intl-ai"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
