[:us:](../../README.md) :jp: [![Build Status](https://travis-ci.org/sachin21/dmm-crawler.svg?branch=master)](https://travis-ci.org/sachin21/dmm-crawler) ![Gem Version](https://badge.fury.io/rb/dmm-crawler.svg) [![Build Status](https://travis-ci.org/sachin21/dmm-crawler.svg?branch=master)](https://travis-ci.org/sachin21/dmm-crawler) [![Code Climate](https://codeclimate.com/github/sachin21/dmm-crawler/badges/gpa.svg)](https://codeclimate.com/github/sachin21/dmm-crawler) [![Gem](https://img.shields.io/gem/dt/dmm-crawler.svg)](https://rubygems.org/gems/dmm-crawler)

# DMM Crawler

## DMM Crawlerとは
DMM.R18のクロールしたデータを取得するgemです。現在、**同人**のランキングにのみ対応しております。

## インストール

Gemfileに以下を追記してください。

```
gem 'dmm-crawler'
```

## 使い方
データを使いたい`.rb`ファイルで以下を実行したらクロールしたデータが取得出来ます。

```ruby
require 'dmm-crawler'

include DMMCrawler

Ranking.new(term: '24', submedia: 'cg').arts

# =>
# {
#   title: "タイトル",
#   url: '作品のURL',
#   image_url: '作品のメイン画像へのURL',
#   tags: ['タグ1', 'タグ2']
# }
```

この例ではCG作品の24時間ランキングのデータを取得しています。

## コントリビューション

1. フォークする
2. 新しくブランチを切る (`git checkout -b my-new-feature`)
3. 変更をコミットする (`git commit -am 'Add some feature'`)
4. 変更をプッシュする (`git push origin my-new-feature`)
5. プルリクエストを投げる :+1:
