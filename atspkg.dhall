let prelude = http://hackage.haskell.org/package/ats-pkg-3.0.0.11/src/dhall/atspkg-prelude.dhall

in prelude.default ⫽
  { test =
    [ prelude.bin ⫽
      { src = "test/test.dats"
      , target = "target/test"
      , libs = [ "unistring" ]
      }
    ]
  , libraries =
    [
      prelude.staticLib ⫽
        { name = "linecount"
        , src = [ "lines.dats" ]
        , libTarget = "target/lib/liblinecount.a"
        }
    ]
  , clib = prelude.mapPlainDeps [ "unistring" ]
  , dynLink = False
  }
