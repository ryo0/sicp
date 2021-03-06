(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m)
                       ) m)
         )
        (else
         (remainder (* base
                       (expmod base (- exp 1) m)
                       ) m)
         )
        )
  )

;;簡単のため、a^(2^n)の計算を考える。
;;元のexpmodでは、expmodが現れる場所が一つで、
;;指数が1になるまで上の再帰、
;;指数が1になってから下の再帰へと潜る。
;;途中で分岐はしていなかったから、深さはlog(2^n)で、
;;それがそのまま計算量となる。
;;一方この再帰では、再帰のたびに道が二つに別れる。
;;つまり、深さはlog(2^n)の完全二分木となり、
;;そのノードと枝の数が計算量であるから、
;;1 + 2 + 4 + … + 2^(n-1) = 2^n-1となる。
;;つまり、m = 2^nとおいてa^mの計算量を考えるとき、
;;前者はΘ(log(m))
;;後者はΘ(m)となる。
