21:35->22:03

22:42->22:50

評価機のデータ構造について、読んで理解した。
特に難しいことはやってないが、なんかやり方が雑というか汚いなあと思っていたが、
脚注で一応「データ抽象化されてない」「効率が悪い」と書いてあった。

extend-environmentが環境の破壊的変更を行っていない事を確認し、安心
入れ子になった環境を扱う場合、破壊的変更を行ってしまうとその環境を抜けても維持されてしまう。
複合手続きを適用する時に、その時に限り非破壊的なextend-environmentを呼び出す、というふうにしているのは、
3章の環境モデルの考え方と合っていると思う。
ということで疑問点ほぼなしかな。