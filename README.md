# 1、beaver 开发简介

beaver 是一款基于lua 异步IO 实现的开发框架，你可以在此基础上，快速开发高并发应用。

开发者要求：
1. 掌握http 基础；
2. 了解异步模型；
3. 掌握lua 编程；

# 2、beaver 目录组成

首先下载beaver 发布包，[链接](https://gitee.com/chuyansz/beaver/releases/download/0.1-1/beaver-x64.0.1-1.tar.gz)，将目录解压后，对应的目录结构如下：

## 2.1、 顶层目录结构

* app: beaver 应用程目录 参考2.2 说明
* install: beaver 依赖第三方库so目录
* lib: beaver 依赖第三方lua so 组件目录
* lua:beaver 依赖第三方纯 lua 组件目录  

## 2.2、app 目录结构

* native 本地库目录，存放了beaver 中C代码的编译文件；
* main 程序入口目录，保存运行脚本，运行程序和配置入口
* lua lua 代码目录，参考2.3 说明

## 2.3、 lua 目录结构

* lua/app：应用代码目录，你可以在这里实现你的应用代码，你不应该去修改当前库目录之外的lua代码
* common/http/module: 通用库目录，不要去修改里面的代码

beaver 应用，采用覆盖式开发，开发者仅需要修改 app/main/config.yaml 配置后，往 app/lua/app 目录下写应用代码即可

# 3、快速实践

