class OriCode < Formula
  desc "ORI Code — terminal coding agent powered by ORI"
  homepage "https://github.com/cassianwolfe/ori-code"
  url "https://github.com/cassianwolfe/ori-code/releases/download/v0.6.5/ori-code-0.6.5.tar.gz"
  sha256 "8e38f0949c850daabb21a0bc61f683bc011a813f12a71d04f8cb0f5d0ef595ea"
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
