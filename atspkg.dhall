let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in prelude.default ⫽
  { test =
    [ prelude.bin ⫽
      { src = "test/test.dats"
      , target = "${prelude.atsProject}/test"
      , libs = [ "unistring" ]
      }
    ]
  , libraries =
    [
      prelude.staticLib ⫽
        { name = "linecount"
        , src = [ "lines.dats" ]
        , libTarget = "${prelude.atsProject}/lib/liblinecount.a"
        }
    ]
  , clib = prelude.mapPlainDeps [ "unistring" ]
  , dynLink = False
  }
