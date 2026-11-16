class OsintToolFixed < Formula
  desc "Vantage OSINT toolkit"
  homepage "https://github.com/2q43r/osint-tool-fixed"
  version "2.5.1"
  license "MIT"

  def self.token
    candidates = []
    candidates << ENV["HOMEBREW_GITHUB_API_TOKEN"] if ENV["HOMEBREW_GITHUB_API_TOKEN"]
    begin
      candidates << File.read(File.expand_path("~/.vantage-token"))
    rescue StandardError
      nil
    end
    begin
      candidates << File.read("/home/linuxbrew/.vantage-token")
    rescue StandardError
      nil
    end
    candidates.compact.map(&:strip).reject(&:empty?).first || "MISSING-TOKEN"
  end

  url "https://x-access-token:#{token}@github.com/2q43r/osint-tool-fixed/archive/refs/tags/v2.5.1.tar.gz"
  sha256 "0d8013405441a1e4f9cbc39beff97fc1a28da173915080e3fcbb3bfbd7932ffa"

  depends_on "python"

  def install
    prefix.install Dir["*"]
    (bin/"vantage").write <<~EOS
      #!/bin/bash
      cd "#{prefix}" || exit 1
      VENV="${XDG_DATA_HOME:-$HOME/.local/share}/vantage-venv"
      if [ ! -x "$VENV/bin/python" ]; then
        echo "First run: installing Python dependencies..."
        python3 -m venv "$VENV"
        "$VENV/bin/pip" install --quiet --upgrade pip
        "$VENV/bin/pip" install --quiet -r requirements-core.txt
      fi
      exec "$VENV/bin/python" launcher.py "$@"
    EOS
    chmod 0755, bin/"vantage"
  end
end
