test:
    @atspkg build
    @./target/test src/fastcount.dats

bench:
    bench "./target/lc test/data/ulysses.txt" "wc -l test/data/ulysses.txt" "./target/lc src/fastcount.dats" "wc -l src/fastcount.dats"

valgrind:
    valgrind ./target/lc src/lib.dats
