class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.illo.fyi"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.7.0/intl-ai-aarch64-apple-darwin.tar.xz"
      sha256 "fc6cddcacbe7a6e484f0296cc57ed0c8e6c63431577ad22d071b317fae275512"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.7.0/intl-ai-x86_64-apple-darwin.tar.xz"
      sha256 "8417895baa67781c20ae38ef3335bb4af72fd41b242dac4a87ce2a1044046f19"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.7.0/intl-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e63febeb831726b95471fbe7e51de7fe51b82c2fde80b8672a4e7de96a09faa7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.7.0/intl-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43dc59586a82d21b7c7ce28e045a7edf71cf16440df4fd35d87339d404e098fc"
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
