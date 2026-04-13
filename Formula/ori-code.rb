class OriCode < Formula
  desc "ORI Code — terminal coding agent powered by ORI"
  homepage "https://github.com/cassianwolfe/ori-code"
  url "https://github.com/cassianwolfe/ori-code/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "93ae060e7ba8e007e2f2601c0801df2813fc9b4150f5b5f779a504b15848d217"
  license "MIT"

  depends_on "oven-sh/bun/bun"

  def install
    system "bun", "install", "--frozen-lockfile"
    (bin/"ori-code").write <<~SH
      #!/bin/bash
      exec bun "#{prefix}/index.tsx" "$@"
    SH
    (bin/"ori").write <<~SH
      #!/bin/bash
      exec bun "#{prefix}/index.tsx" "$@"
    SH
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      Set your ORI API key before running:
        export ORI_API_KEY=glm.<prefix>.<secret>

      Add that to ~/.zshrc to make it permanent.
    EOS
  end

  test do
    assert_match "ori-code", shell_output("#{bin}/ori-code --help 2>&1")
  end
end
