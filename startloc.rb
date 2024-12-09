class Startloc < Formula
  desc "Tool to dynamically set the starting location for terminal sessions"
  homepage "https://github.com/nishu-builder/startloc"
  url "https://github.com/nishu-builder/startloc/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "b0a987f641f8d9a506b0ff909b99b68f5a42b533a3ce0e259726a3aa5be65df4"

  def install
    bin.install "install_startloc.sh" => "startloc"
  end

  test do
    output = shell_output("#{bin}/startloc 2>&1", 1)
    assert_match(/Usage: startloc <path>|Neither \.zshrc nor \.bashrc was found in your home directory\./, output)
  end
end
