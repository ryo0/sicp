; 13:27->13:43
; 13:48->14:10

三つの口座の残高が最初は 10 ドル、20 ドル、30 ドルで、
それから複数のプロセスが実行されて口座の残高を交換するとする。

Q1.プロセスが逐次的に実行されるとしたら、並行の残高 交換を何回行ったとしても、
口座残高は何らかの順番で 10 ドル、 20 ドル、30 ドルであるということを論証せよ。

A1.逐次的に実行される場合、どの口座が何ドルを持つかを交換するだけなので、
順序が変わるだけになる。順序を変える操作を何度繰り返しても順序が変わるだけである。

Q2.この章の最初のバージョンの口座交換プログラムを使って残高交換を実装すると
  この条件が破られることもあるということを、図 3.29のようなタイミング図を描いて示せ。
A2. 図はダルいので文字で（図にする事は難しくないし）
a1(10), a2(20), a3(30)
まずPeterの操作により、a1とa2の差額10が計算される
Peterがa1とa2の残高を更新する前に、
Paulがa2とa3の残高を交換する処理を行う
a1(10), a2(30), a3(20)
Peterが差額10に基いてa1とa2の残高を交換する
a1(20), a2(20), a3(20)

Q3. 一方、この exchange プログラムを使った としても、口座残高の合計は保存されることを論証せよ。
A3.
Q2のパターンでは、
金額の入れ替えとして行われるのは、
並び替え操作、及び間違った差額に基づいた交換の二つである。
並び替え操作は残高の合計を保存する。
また、間違った差額に基づいた交換も、一方の残高を減らした分だけもう一方の残高が増えるので、
口座残高の合計は保存される。

また、他に考えられるパターンとして、
exchangeのwithdrawとdepositの間に別のプロセスのexchangeが行われる、という事がありうる。
この場合、例えば
a1(10), a2(20), a3(30)
a2とa1の差額10を計算し、a2から10ドルを引く
a1(10), a2(10), a3(30)
a2とa3のexchangeプロセスが走る
a1(10), a2(30), a2(10)
a2とa1のexchangeプロセスの残りが実行され、a1に10ドル加えられる
a1(20), a2(30), a2(10)
このようになるが、この場合でもどこかで減った分だけ必ずどこかで加えられる。
そのため、口座残高の合計は保存される。

Q4.
個別口座の取引を直列化しなければこの前提まで破られるということを タイミング図を描いて示せ。
A3.図はパス。文字で。
a1(10), a2(20), a3(30)
について、a1とa2の交換操作とa1とa3の交換操作が直列化なしで行われるとする。

a1(10), a2(20), a3(30)について
1.1. a1とa2の交換操作を開始。まず差額を計算し、a2から10ドル引く
   a1(10), a2(10), a3(30)
1.2. a1の残高を読み込む。a1残高:10ドル、差額:+10ドル
   a1(10), a2(10), a3(30)
2.1. a1とa3の交換操作をする。
   a1(30), a2(10), a3(10)
1.3. 1.2に基いて a1にdeposit。a1残高:10ドル、差額:+10ドルであるため、a1は20ドルになる
   a1(20), a2(10), a3(10)
合計金額が10ドル減った。