let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in prelude.default //
  { test = 
    [ prelude.bin //
      { src = "src/test.dats"
      , target = "target/test"
      }
    ]
  }
