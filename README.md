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

# 2.4、总结

beaver 应用，采用覆盖式开发，开发者仅需要修改 app/main/config.yaml 配置后，往 app/lua/app 目录下写应用代码即可

# 3、快速实践

我们以最简单的hello 为例，它由一个配置文件和功能函数组成

## 3.1、配置文件

main/config.yaml

```yaml
worker:  # 标记工作线程
  number: 1   # 工作线程数量
  funcs:  # 功能列表
    - func: "httpServer"   # http server 服务
      mode: "TCP"    # TCP 了类型
      bind: "0.0.0.0"   # 绑定IP
      port: 2000        # 绑定端口号
      entry: "hello"  # 入口 函数 对应在 lua/app 目录下的文件
```

## 3.2、功能代码

以下代码在 hello 分支中：lua/app/hello.lua

```lua
require("eclass")  --引入构造类声明

local Chello = class("hello")  --类声明

local function index(tReq)   -- 回调函数
    return {body = string.format("hello guys!")}
end

function Chello:_init_(inst, conf)  -- 类构造函数
    inst:get("/", index)   -- 注册回调
end

return Chello  -- 返回类
```

构造函数：

* inst 传入了httpServer 实例，你可以注册对应url的回调函数，方法有 get/put/post/delete，url 可以为字符串（优先级高）或者 lua 正则表达式
* conf 传入了yaml 中的 worker->funcs 中的配置

回调函数， 入参tReq 类型为 table， 包含

* headers：类型为table，对应http 首部；
* body： 类型为 string， http 内容；
* verb：类型为 string， http 方法；
* version：类型为 string， http 版本；
* path：类型为 string， http 请求url路径；
* origUrl：类型为 string，原始http url；
* query：类型为 string，http query 列表；
* queries：类型为table，http query 列表；
* params：类型为 string，http params 列表;
* paramses：类型为table，http paramses 列表；
* ……

请不要修改tReq 里面的成员信息，避免非预期影响

返回值应包含 headers 和body 的table 数据。

## 3.3、渲染markdown

下面的代码在markdown 分支中，lua/common/lmd 支持将markdown 文档渲染成网页，方便页面呈现。

```lua
……
local pystring = require("pystring")  --用于字符串和文件处理
local lmd = require("common.lmd")  -- 渲染markdown
local mdInst = lmd.new()   -- 创建内部markdown实例
……

-- 回调函数
local function readme(tReq)
    local headers = {   --声明首部以及html 编码方式
        ["Content-Type"] = "text/html; charset=UTF-8",
    }
    local md = pystring.with("../README.md")   -- 读取markdown内容
    return {headers = headers, body = mdInst:toHtml(md)}
end
……

```

更新部署后，即可用chrome 浏览器查看到渲染后的markdown 效果。



