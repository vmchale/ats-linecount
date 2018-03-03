#include "lines.dats"

implement main0 (argc, argv) =
  {
    val () = (println!(line_count("lines.dats"), " lines.dats"))
    val str = string0_copy("ðç")
    val n = utf_length(str)
    val _ = strptr_free(str)
    val () = println!(n)
  }
