class IntlAi < Formula
  desc "AI-powered build-time i18n translation CLI"
  homepage "https://intl-ai.pages.dev"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.6.0/intl-ai-aarch64-apple-darwin.tar.xz"
      sha256 "40ca877f0e33b4327858c7b07f0caf293269281294b2af06fb656f3ee44f45e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.6.0/intl-ai-x86_64-apple-darwin.tar.xz"
      sha256 "249334a3015dd99512a56e636c3a23ce133fc62cf0bd5b29c53ae64d81b3b2cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.6.0/intl-ai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1dd233457d28dc37602931feed2f74ca9df87a3bc06b532c62bda2f54ad8d52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sigilco/intl-ai/releases/download/v0.6.0/intl-ai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4b88f2109122e7486cbc04756aa2f52b182398fc6ecac9032f1100a070ca7f4"
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
