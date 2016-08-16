class GitDrip < Formula
  desc "A collection of Git extensions to provide high-level repository operations for the git-drip workflow"
  homepage "https://github.com/jbarone/gitdrip"
  url "https://github.com/jbarone/gitdrip/archive/v0.2.0.tar.gz"
  version "0.2.0"
  sha256 "b856d07b951901dc31054ebe7bc4b29301787bba99b224fe9c2cc9c561b2b489"

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
