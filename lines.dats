(*
**
** A fast approach to counting newlines
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: April 17, 2013
**
*)
#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/stdio.sats"

%{^
extern void *rawmemchr(const void *s, int c);
#define atslib_rawmemchr rawmemchr
%}

extern
fun rawmemchr {l:addr}{m:int}(pf : bytes_v(l, m) | p : ptr(l), c : int) :
  [ l2 : addr | l+m > l2 ] (bytes_v(l, l2-l), bytes_v(l2, l+m-l2) | ptr(l2)) =
  "mac#atslib_rawmemchr"

#define BUFSZ (32*1024)

extern
fun freadc {l:addr} (pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : char) : size_t

implement freadc (pf | inp, p, c) =
  let
    var n = $extfcall(size_t, "fread", p, sizeof<char>, BUFSZ - 1, inp)
    val () = $UN.ptr0_set<char>(ptr_add<char>(p, n), c)
  in
    n
  end

extern
fun wclbuf {l:addr}{n:int} (pf : !bytes_v(l, n) | p : ptr(l), pz : ptr, c : int, res : int) :
  int

implement wclbuf (pf | p, pz, c, res) =
  let
    val (pf1, pf2 | p2) = rawmemchr(pf | p, c)
  in
    if p2 < pz then
      let
        prval (pf21, pf22) = array_v_uncons(pf2)
        var res = wclbuf(pf22 | ptr_succ<byte>(p2), pz, c, res + 1)
        prval () = pf2 := array_v_cons(pf21, pf22)
        prval () = pf := bytes_v_unsplit(pf1, pf2)
      in
        res
      end
    else
      let
        prval () = pf := bytes_v_unsplit(pf1, pf2)
      in
        res
      end
  end

extern
fun wclfil {l:addr} (pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : int) : int

implement wclfil {l} (pf | inp, p, c) =
  let
    fun loop(pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : int, res : int) : int =
      let
        val n = freadc(pf | inp, p, $UN.cast{char}(c))
      in
        if n > 0 then
          let
            var pz = ptr_add<char>(p, n)
            var res = wclbuf(pf | p, pz, c, res)
          in
            loop(pf | inp, p, c, res)
          end
        else
          res
      end
  in
    loop(pf | inp, p, c, 0)
  end

fn count_char(s : string, c : char) : int =
  let
    var inp: FILEref = fopen_ref_exn(s, file_mode_r)
    val (pfat, pfgc | p) = malloc_gc(g1i2u(BUFSZ))
    prval () = pfat := b0ytes2bytes_v(pfat)
    var res = wclfil(pfat | inp, p, $UN.cast2int(c))
    val () = mfree_gc(pfat, pfgc | p)
    val _ = fclose_exn(inp)
  in
    res
  end

extern
fun utf_bounded_length(s : !Strptr1, n : size_t) : size_t =
  "mac#u8_mbsnlen"

extern
fun utf_bytes(s : !Strptr1) : size_t =
  "mac#u8_strlen"

// Takes as an argument the file path.
extern
fun line_count(string) : int =
  "mac#"

fun utf_length(s : !Strptr1) : size_t =
  let
    var n = utf_bytes(s)
  in
    utf_bounded_length(s, n)
  end

implement line_count (s) =
  count_char(s, '\n')
