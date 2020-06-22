# ldhookgen

auto generator functions for hook by `LD_PRELOAD`

you can generate functions from only symbol names (without arg infos)

for `x86_64` only

## how to build
run build command at test directory
```
cp test/libtrace_test .
./auto_gen.sh
```

## how to run
```
LD_LIBRARY_PATH=. ./libtrace_test
LD_LIBRARY_PATH=. LD_PRELOAD=./libauto_gen.so ./libtrace_test
```

## 開発のステップ
* `test`のディレクトリで手動でプログラムを変更して検証し，OKと判断したら，テンプレートの方にそれを反映し，自動生成できるようにする

## memo
* `nm`でシンボル情報が取れない場合は`objdump -R`でシンボル情報がとれる

## TODO
* post call hook対応
  * フックした関数の実行時間取得
* ログ出力
  * 関数呼び出しのindent
  * TID
* シンボルの変数と関数の区別をする方法の調査

## ltraceとの比較
* `ltrace`では`LD_PRELOAD`ではなく`ptrace`を利用しているため仕組みが異なる
  * `plt`を利用しないバインド方法では`ltrace`ではトレースができない(e.g. rustバイナリの`malloc`)
* `ltrace`コマンドが存在しない環境でも利用可能
