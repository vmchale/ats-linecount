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

extern
fun memchr {l:addr}{m:int}(pf : bytes_v(l, m) | p : ptr(l), c : char, sz : size_t) :
  [ l2 : addr | l+m > l2 ] (bytes_v(l, l2-l), bytes_v(l2, l+m-l2)| ptr(l2)) =
  "mac#"

#define BUFSZ (32*1024)

fn freadc {l:addr}(pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : char) : size_t =
  let
    var n = $extfcall(size_t, "fread", p, sizeof<char>, BUFSZ - 1, inp)
    val () = $UN.ptr0_set<char>(ptr_add<char>(p, n), c)
  in
    n
  end

fun wclbuf {l:addr}{n:int}(pf : !bytes_v(l, n) | p : ptr(l), pz : ptr, c : char, res : int) :
  int =
  let
    val (pf1, pf2 | p2) = memchr(pf | p, c, i2sz(BUFSZ))
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

fn wclfil {l:addr}(pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : char) : int =
  let
    fun loop(pf : !bytes_v(l, BUFSZ) | inp : FILEref, p : ptr(l), c : char, res : int) : int =
      let
        val n = freadc(pf | inp, p, c)
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
    var res = wclfil(pfat | inp, p, c)
    val () = mfree_gc(pfat, pfgc | p)
    val _ = fclose_exn(inp)
  in
    res
  end

extern
fn utf_bounded_length(s : !Strptr1, n : size_t) : size_t =
  "mac#u8_mbsnlen"

extern
fn utf_bytes(s : !Strptr1) : size_t =
  "mac#u8_strlen"

// Takes as an argument the file path.
extern
fn line_count(string) : int =
  "mac#"

fn utf_length(s : !Strptr1) : size_t =
  let
    var n = utf_bytes(s)
  in
    utf_bounded_length(s, n)
  end

implement line_count (s) =
  count_char(s, '\n')
