class OsintToolFixed < Formula
  desc "Vantage OSINT toolkit"
  homepage "https://github.com/2q43r/osint-tool-fixed"
  url "https://github.com/2q43r/osint-tool-fixed/archive/refs/tags/v2.5.0.tar.gz"
  sha256 "8b53fa296cbb9fb1ca25bf8f1c02237220a981c3f3c7f29f3c3c22800ce24267"
  version "2.5.0"
  license "MIT"

  depends_on "python"

  def install
    prefix.install Dir["*"]
    chmod 0755, "#{prefix}/launcher.py"
    (bin/"vantage").write <<~EOS
      #!/bin/bash
      cd "#{prefix}" || exit 1
      exec "#{Formula["python@3.15"].opt_bin}/python3.15" launcher.py "$@"
    EOS
    chmod 0755, bin/"vantage"
  end
end
