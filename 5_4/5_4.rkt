9:51->10:51
10:56->11:01
13:18->14:18
14:25->14:28
14:35->14:47
14:47->15:02

10:13->10:26

また一週間ぶり。
今回も読むだけ。
---
5.4.1
---
なるほど。
基本演算を色々用意しておくから想像してたほどえげつないことにはならないらしい。
---
いつもどおり理解度チェックのためのトレースをやる
---
(define example
  (lambda (a b)
    (+ a b)
  )
)

(define x 2)
---
上の環境で
(example (+ 1 x) (+ 3 x))
を評価するとき、を考えてみる
まず
dispatchでev-applicationに移り、
continueとenvがスタックに積まれ、
envにはexampleとxが保存され、
unevには((+ 1 x) (+ 3 x))が保存される。
expにはexampleが保存される。
この状態で、もう一回dispatch。
ただし、continueにはev-appl-did-operatorが保存されている。

次は(+ 1 x)を見ることになる。
envはさっきと同じ。
unevには(1 x)がさっきのものに乗っかる
expには+が来る。
この状態で、更にcontinueにev-appl-did-operatorが代入され
もう一回dispatch。
+がどう評価されるのか書いてないな…。

まだ本に出てきてないコードも読んでみる。
恐らく+でev-variableに引っかかり、
+がvalに代入された状態で
ev-appl-did-operator
に移り、
1, xおよび環境を持っててきつつ、
apply-dispatchに飛ぶ。
そこのprimitive-procedure?に引っかかり、
更にprimitive-applyに引っかかり、
…ここで詰まった。
agrlってここまで追いかけた感じだと、空リストのはずなんだけどな…
先を読み進めよう
なるほど、掲載コードの表記が悪い気がする。
スペースあいてるけど、
ev-appl-did-operator
で(save proc)したあとはそのまま
ev-appl-operand-loop
に進むんだな。
なら完全に納得がいくわ
---
1の評価とx=2の評価をした上でarglを(1 2)とし
（arglの詳細は普通に追えたけど結構煩雑なのでスキップ）
その状態でprimitive-applyに向かうから、(+ 1 2)が計算できるはずだ。
example視点でも引数それぞれに対してこれを再帰的に繰り返していくだけだから、
もうほぼ納得行ったかなと思う
---
5.4.2
---
しばらく間違った考察が続きます。
---
末尾再帰版とそうじゃない版のev-sequence、何が違うんだろう？
(define (length l counter)
  (if (null? l)
    counter
    (length (cdr l) (+ counter 1))))
っていう式があって、
(length '(1 2 3) 0)
と呼ばれた場合、
まず評価されるのは
(length '(2 3) (+ 0 1))
これ。
これが今まさに評価されようとしている時に、
dispatchが呼ばれるのなら、
単純にこの引数でもう一度lengthが評価されるだけになる。
その繰り返しなので、多分スタックが積み上がることなく普通に処理される。

dispatchに行くんじゃなくて、
スタックの一番上にあるcontinueに行くとしたらどうなるか。
そもそもここでcontinueが持ってるのは何か？
---
ここまで間違った考察。
---
ネットの解説ブログ見てると、上の考察そもそもポイント違うっぽいなあ。
わかったぞ。
残り一つかどうかをチェックして、
スタックに値を積むかどうか決める版が末尾再帰版
残り0かどうかをチェックして、
スタックに値を積むかどうか決める版が非末尾再帰版
ってことだろう、多分。
最後一つの時はスタックに積まないというふうにすれば、
すなわち末尾再帰呼出しのときはスタックに積まない事を意味する。
そうすればスタックが増えない。
理屈的にはそういうことのはず。ここを踏まえてもう一度読もう。
---
あーわかった。
dispatchに飛ぶんじゃなくてcontinue呼んでるのは最後がもう評価済みだからだ。
ここは末尾再帰とは直接は関係ない。
---
そして、
unevは未評価の式の集まりであり、
envは未評価の式を評価するための環境なので、
最後の段階でこれら2つを保存するというのは、
最後の式（再帰の式）と最後の式（再帰の式）を評価するための環境を保存する、
ということになるが、
これはレジスタに保持してればいいだけのことなので、無駄である。
---
ev-sequenceで、列の最後の再帰呼び出し部分に来たとき。
再帰呼び出しの直前にスタックに再帰の式と再帰の式の環境が積まれ、
その状態でeval-dispatchに飛び、再帰が評価される。
式の評価が終わったら
ev-sequence-continue
で復元が行われる。
ただし、これは再帰が一周で終わった場合の話で、
再帰がn周ならn回スタックに積まれ、n回スタックから無駄なペアを取り出すという事になる、はず。
ということで、理解できた！
---
5.4.3
---
さっきから思ってたけど、行き先をcontinueに保存しつつgotoで回していく感じが、
とっても4.3.3の非決定性計算インタプリタの実装に似ている。
本質的に継続そのものなのだろうな、多分。
4.3.3は読み飛ばさなくてよかったかも
---
if, set! defineに関しては、ほぼ完全にメタ循環評価器と同じかな。
強いて言うならcontinueとラベルにやや注意が必要ってぐらいか。
---
5.4.4
---
特記事項なし。
---
---
---
末尾再帰じゃない、こういう再帰で何がどうなってるのかが唐突に気になった
---
(+ 1 (length (cdr l)))
---
unevに(1 (length (cdr l)))が保存され、
expに+が保存されて
eval-dispatchへGo
+がprimitiveであることが判明し、
ev-appl-did-operatorへGo
1をexpに保存し、eval-dispatchへGo
1はそれ自身が値なので、
すぐにev-appl-accumulate-argへGo
arglが(1)になり、
unevに(length (cdr l))が保存されて、
ev-appl-operand-loopへGo
argl=(1)がスタックに積まれ（ココ重要）
expに(length (cdr l))が保存されて、
最後のオペランドなので、
ev-appl-last-argへGo
continueにev-appl-accum-last-argが代入されて、
eval-dispatchへGo。
これが l が nil になるまで続き、
再帰の度にarglがスタックに積まれ続けるので、
線形に空間計算量が増えていく、という寸法。
最後に
continueにev-appl-accum-last-argが代入されているので、
再帰部分の計算が終わったらここに帰ってきて、
arglを(1 ((cdr l)の長さ)として和を計算をして再帰から戻る、
という形だと思う。
