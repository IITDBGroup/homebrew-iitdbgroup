# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Gprom < Formula

  desc "GProM is a middleware that adds support for provenance to database backends."
  homepage "http://www.cs.iit.edu/%7edbgroup/research/gprom.php"
  url "https://github.com/IITDBGroup/gprom/releases/download/v1.0.0/gprom-1.0.0.tar.gz"
  sha256 "48a6d341ea47b291a291f2e12070048264a2b36a9e011bc19f3c11f7522fa290"
  head "https://github.com/IITDBGroup/gprom.git"
  version "1.0.0"
  
  depends_on "cmake" => :build
  depends_on "bison" => :build
  depends_on "readline" => :recommended
  depends_on "sqlite" => :recommended
  depends_on "postgres" => :recommended
  depends_on "monetdb" => :recommended
  depends_on :java => [:optional,"1.6+"]

  option "with-oracle", "Compile with support for accessing oracle (OCILIB required)"
  
  def install
    args = %w[
           --disable-debug
           --disable-dependency-tracking
           --disable-silent-rules
           --prefix=#{prefix}
    ]

    unless build.with? "oracle"
      args += %w[--disable-oracle]
    end
    unless build.with? "java"
      args += %w[--disable-java]
    end
    
    system "./configure", *args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gprom`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#bin/gprom -version"
  end
end
