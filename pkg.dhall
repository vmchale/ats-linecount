let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in prelude.dep //
  { libName = "linecount"
  , dir = ".atspkg/contrib"
  , url = "https://github.com/vmchale/ats-linecount/archive/0.2.5.tar.gz"
  , libVersion = [0,2,5]
  -- , libCDeps = prelude.mapPlainDeps [ "unistring" ]
  }
