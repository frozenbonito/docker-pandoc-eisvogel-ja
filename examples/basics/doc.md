---
title: 基本的な使い方のサンプル
subtitle: サブタイトル
date: 2020-05-06
author: frozenbonito
---

# 概要

日本語で書いた Markdown を PDF に変換できます。

# 見出しサンプル

## 見出し 2

### 見出し 3

# 各記法のサンプル

## 箇条書きリスト

- アイテム 1
- アイテム 2
- アイテム 3
  - アイテム 3-1
    - アイテム 3-1-1

## 番号付きリスト

1. アイテム 1
1. アイテム 2
1. アイテム 3
   1. アイテム 3-1
      1. アイテム 3-1-1

## 引用

> 引用です。
>
> > 二重引用です。

## リンク

[Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template) を使っています。

## テーブル

| 左寄せ | 中央 | 右寄せ |
| :----- | ---- | -----: |
| い     | ろ   |     は |
| に     | ほ   |     へ |

## コード

### インライン

`docker run` で実行してください。

### コードブロック

```go
package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
}
```
