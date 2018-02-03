#include "src/lib.dats"
#include "src/fastcount.dats"

implement main0 (argc, argv) =
  {
    val () = (if argc >= 2 then
      (println!(line_count(argv[1]), " ", argv[1])))
  }