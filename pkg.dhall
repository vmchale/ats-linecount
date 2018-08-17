let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.dep ⫽
    { libName = "linecount"
    , dir = prelude.patsHome
    , url = "https://github.com/vmchale/ats-linecount/archive/${prelude.showVersion x}.tar.gz"
    , libVersion = x
    }
