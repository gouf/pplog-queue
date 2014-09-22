#pplog-queue

[![Coverage Status](https://coveralls.io/repos/gouf/pplog-queue/badge.png?branch=dev)](https://coveralls.io/r/gouf/pplog-queue?branch=dev)
[![Build Status](https://travis-ci.org/gouf/pplog-queue.png?branch=dev)](https://travis-ci.org/gouf/pplog-queue)

ぽえみをちょっと便利に。

はじめてのSinatra アプリケーションを作りました。
[pplog.net](http://www.pplog.net/) という外部サービスに投稿できるアプリケーションです。

Mechanize を橋渡しに、ローカルにポエムをストックして投稿することができるというシンプルな機能になっています。

## Setup

```
bower install
bundle install
```

login.yml
edit login info:
```
user_name: 'your_user_name'
password: 'your_pass_word'
```



## Run and use

```
rackup -p 9292
```

Access to http://localhost:9292/
