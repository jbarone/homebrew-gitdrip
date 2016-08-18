class GitDrip < Formula
  desc "Collection of Git extensions to provide operations for the git-drip workflow"
  homepage "https://github.com/jbarone/gitdrip"
  url "https://github.com/jbarone/gitdrip.git",
    :tag => "v0.3.1",
    :revision => "30fcbb6d8c21c1f1d01b1811bb1deb254209bf20"

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
