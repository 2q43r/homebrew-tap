class OsintToolFixed < Formula
  desc "Vantage OSINT toolkit"
  homepage "https://github.com/2q43r/osint-tool-fixed"
  url "https://github.com/2q43r/osint-tool-fixed/archive/refs/tags/v2.5.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  version "2.5.0"
  license "MIT"

  depends_on "python"

  def install
    prefix.install Dir["*"]
    bin.write_exec_script "#{prefix}/launcher.py"
  end
end
