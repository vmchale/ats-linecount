test:
    @atspkg build
    @./target/test src/fastcount.dats

bench:
    bench "./target/test ~/programming/haskell/done/wordchoice/test/data/ulysses.txt" "wc -l ~/programming/haskell/done/wordchoice/test/data/ulysses.txt"

valgrind:
    valgrind ./target/test src/lib.dats
