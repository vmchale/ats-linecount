let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in prelude.default //
  { test = 
    [ prelude.bin //
      { src = "src/test.dats"
      , target = "target/test"
      , libs = [ "unistring" ]
      }
    ]
  -- , libraries =
  --   [
  --     prelude.staticLib //
  --       { name = "linecount"
  --       , src = [ "src/test.dats" ]
  --       , libTarget = "target/lib/liblinecount.a"
  --       }
  --   ]
  , clib = prelude.mapPlainDeps [ "unistring" ]
  }
