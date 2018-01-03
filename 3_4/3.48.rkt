; 11:10->11:31
まず番号を振らない時どうなるのかがよくわからないのでそこから考える
Peterがa1とa2を交換しようとする
Paulがa2とa1を交換しようとする
Peterはa1を確保し、続けてPaulはa2を確保。
Peterがa2を確保するには、Paulが解放しなくてはいけない。
Paulがa1を確保するには、Peterが解放しなくてはいけない。
お互いがお互いの解放を待っていて、永遠に終わらない。
ということかな？

口座に番号が振られていて、その番号が一番小さいものから獲得を試みる、とした場合、
a1は1、a2は2が振られているとすると、
Peterがa1を確保したあと、Paulはa2の確保よりa1の確保を優先するので待機する。
そうしてPeterはa2の確保へと進むことが出来る。
Peterがa1, a2の交換を行い、二つを解放、
Paulがa1, a2の確保、交換、解放を行う、という順序になる。

このように残高交換問題においてデッドロックが発生するのは、
口座確保の順番がそれぞれ違っている事による。
もし口座確保の順番が一定なら、
もう一つのプロセスがほしいものを既に確保済みであるという事は起こり得ないので、
問題がない。

実装はダルいのでパス