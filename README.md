# pplog-queue

[![Coverage Status](https://img.shields.io/coveralls/gouf/pplog-queue.svg)](https://coveralls.io/r/gouf/pplog-queue?branch=master)
[![Build Status](https://travis-ci.org/gouf/pplog-queue.svg?branch=master)](https://travis-ci.org/gouf/pplog-queue)
[![Code Climate](https://codeclimate.com/github/gouf/pplog-queue/badges/gpa.svg)](https://codeclimate.com/github/gouf/pplog-queue)

ぽえみをちょっと便利に。

はじめてのSinatra アプリケーションを作りました。
[pplog.net](http://www.pplog.net/) という外部サービスに投稿できるアプリケーションです。

Mechanize を橋渡しに、ローカルにポエムをストックして投稿することができるというシンプルな機能になっています。

## Setup

```sh
bower install
bundle install
touch login.yml # if not exists.
```

### login.yml

edit login info:

```yaml
user_name: 'your_user_name'
password: 'your_pass_word'
```



## Run and use

```
bundle exec rackup -p 9292
```

Access to http://localhost:9292/
