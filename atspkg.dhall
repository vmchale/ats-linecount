let pkg = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default.dhall
in
let dbin = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default-bin.dhall

in pkg //
  { bin = 
    [ dbin //
      { src = "src/test.dats"
      , target = "target/lc"
      }
    ]
    , compiler = [0,3,9]
    , version = [0,3,9]
    , ccompiler = "gcc"
  }
