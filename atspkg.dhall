let pkg = https://raw.githubusercontent.com/vmchale/atspkg/master/dhall/default.dhall
in
let dbin = https://raw.githubusercontent.com/vmchale/atspkg/master/dhall/default-bin.dhall

in pkg //
  { test = 
    [ dbin //
      { src = "src/test.dats"
      , target = "target/test"
      }
    ]
  }
