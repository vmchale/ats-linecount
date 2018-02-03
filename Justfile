test:
    @atspkg build
    @./target/test src/fastcount.dats

bench:
    bench "./target/test test/data/ulysses.txt" "wc -l test/data/ulysses.txt"

valgrind:
    valgrind ./target/test src/lib.dats
