class Gprom < Formula
  desc "Middleware that adds support for provenance to database backends"
  homepage "http://www.cs.iit.edu/%7edbgroup/research/gprom.php"
  url "https://github.com/IITDBGroup/gprom/releases/download/v1.0.0/gprom-1.0.0.tar.gz"
  sha256 "48a6d341ea47b291a291f2e12070048264a2b36a9e011bc19f3c11f7522fa290"
  head "https://github.com/IITDBGroup/gprom.git"

  option "with-oracle", "Compile with support for accessing oracle (OCILIB required)"

  depends_on "cmake" => :build
  depends_on "bison" => :build
  depends_on "readline" => :recommended
  depends_on "sqlite" => :recommended
  depends_on "postgresql" => :recommended
  depends_on "monetdb" => :recommended
  depends_on :java => [:optional, "1.6+"]

  def install
    args = %w[
  --disable-debug
  --disable-dependency-tracking
  --disable-silent-rules
    ]

    unless build.with? "oracle"
      args += %w[--disable-oracle]
    end
    unless build.with? "java"
      args += %w[--disable-java]
    end
    if build.without? "sqlite"
      args += %w[--disable-sqlite]
    end
    if build.without? "postgres"
      args += %w[--disable-postgres]
    end
    if build.without? "monetdb"
      args += %w[--disable-monetdb]
    end

    system "./configure", "--prefix=#{prefix}", *args
    system "make", "install"
  end

  test do
    system "#bin/gprom", "-version"
  end
end
