class Startloc < Formula
  desc "Tool to dynamically set the starting location for terminal sessions"
  homepage "https://github.com/nishu-builder/startloc"
  url "https://github.com/nishu-builder/startloc/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "668cc6d4da96a068520b17a1ef8a0ffb928570084a9591c019e823ef8109bfe3"

  def install
    bin.install "install_startloc.sh" => "startloc"
  end

  test do
    output = shell_output("#{bin}/startloc 2>&1", 1)
    assert_match(/Usage: startloc <path>|Neither \.zshrc nor \.bashrc was found in your home directory\./, output)
  end
end
