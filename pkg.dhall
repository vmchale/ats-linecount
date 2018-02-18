let dep = https://raw.githubusercontent.com/vmchale/atspkg/master/dhall/default-pkg.dhall

in dep //
  { libName = "linecount"
  , dir = ".atspkg/contrib"
  , url = "https://github.com/vmchale/ats-linecount/archive/0.2.4.tar.gz"
  , libVersion = [0,2,4]
  }
