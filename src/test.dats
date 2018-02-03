#include "lines.dats"

implement main0 (argc, argv) =
  {
    val () = (println!(line_count("test/data/ulysses.txt"), " test/data/ulysses.txt"))
  }