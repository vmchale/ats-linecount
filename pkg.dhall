let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.dep ⫽
    { libName = "linecount"
    , dir = ".atspkg/contrib"
    , url = "https://github.com/vmchale/ats-linecount/archive/${prelude.showVersion x}.tar.gz"
    , libVersion = x
    }
