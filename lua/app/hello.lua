---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by liaozhaoyan.
--- DateTime: 2024/1/31 7:29 PM
---

require("eclass")

local Chello = class("hello")

local function index(tReq)
    return {body = string.format("hello guys!")}
end

function Chello:_init_(inst, conf)
    inst:get("/", index)
end

return Chello