class OriCode < Formula
  desc "ORI Code — terminal coding agent powered by ORI"
  homepage "https://github.com/cassianwolfe/ori-code"
  url "https://github.com/cassianwolfe/ori-code/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "42ca3ffe5883cae949a40223dd78e75bb33d9f59afb1085a7e30323711e58ecf"
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
