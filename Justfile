test:
    @atspkg build
    @./target/test src/fastcount.dats

bench:
    bench "./target/test test/data/ulysses.txt" "wc -l test/data/ulysses.txt" "./target/test src/fastcount.dats" "wc -l src/fastcount.dats"

valgrind:
    valgrind ./target/test src/lib.dats
