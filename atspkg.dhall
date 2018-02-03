let pkg = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default.dhall
in
let dbin = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default-bin.dhall

in pkg //
  { test = 
    [ dbin //
      { src = "src/test.dats"
      , target = "target/test"
      }
    ]
    , compiler = [0,3,9]
    , version = [0,3,9]
    , ccompiler = "gcc"
  }
