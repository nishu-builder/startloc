class Startloc < Formula
  desc "Tool to dynamically set the starting location for terminal sessions"
  homepage "https://github.com/nishu-builder/startloc"
  url "https://github.com/nishu-builder/startloc/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "a28d2f7b27d5e0e2bf4698a2b2c3f66f4ea804e4ce9dcec68450729b8e22b073"

  def install
    bin.install "install_startloc.sh" => "startloc"
  end

  test do
    output = shell_output("#{bin}/startloc 2>&1", 1)
    assert_match(/Usage: startloc <path>|Neither \.zshrc nor \.bashrc was found in your home directory\./, output)
  end
end
