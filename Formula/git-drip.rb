class GitDrip < Formula
  desc "A collection of Git extensions to provide high-level repository operations for the git-drip workflow"
  homepage "https://github.com/jbarone/gitdrip"
  url "https://github.com/jbarone/gitdrip/archive/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "b63c3d3e008387363cbd2a89976ce5731712beefcc9c424864ab9b896510d818"

  resource "completion" do
    url "https://github.com/jbarone/git-drip-completion.git", :branch => "master"
  end


  def install
    system "make", "prefix=#{libexec}", "install"
    bin.write_exec_script libexec/"bin/git-drip"

    resource("completion").stage do
      bash_completion.install "git-drip-completion.bash"
      zsh_completion.install "git-drip-completion.zsh"
    end
  end

  test do
    system "git", "drip", "init", "-d"
    assert_equal "master", shell_output("git rev-parse --abbrev-red HEAD").strip
  end
end
