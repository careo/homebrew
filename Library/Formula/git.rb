require 'formula'

class GitManuals <Formula
  url 'http://kernel.org/pub/software/scm/git/git-manpages-1.6.5.2.tar.bz2'
  md5 'e4c20bd92b7ec187a421c045ae99978a'
end

class Git <Formula
  url 'http://kernel.org/pub/software/scm/git/git-1.6.5.2.tar.bz2'
  md5 '99708c449b23433136dbdfa38bd16d80'
  homepage 'http://git-scm.com'

  def install
    # sadly, there's a bug in LLVM:
    # http://www.mail-archive.com/llvmbugs@cs.uiuc.edu/msg03791.html
    ENV.gcc_4_2

    # if these things are installed, tell git build system to not use them
    ENV['NO_FINK']='1'
    ENV['NO_DARWIN_PORTS']='1'

    system "./configure --prefix=#{prefix}"
    system "make install"

    # Install the git bash completion file
    etc.install 'contrib/completion/git-completion.bash'

    # these files are exact copies of the git binary, so like the contents
    # of libexec/git-core lets hard link them
    # I am assuming this is an overisght by the git devs
    %w[git-receive-pack git-upload-archive].each do |fn|
      next unless (bin+'git').stat.size == (bin+fn).stat.size
      (bin+fn).unlink
      (bin+fn).make_link bin+'git'
    end

    # we could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier
    GitManuals.new.brew { man.install Dir['*'] }
  end
end
