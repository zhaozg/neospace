local a = require("user.await")
local http = require("http")

function main_loop()
  print("main_loop")
end

function get(cb)
  http.get("http://baidu.com", function(res)
    print(res.statusCode)
    print(res.httpVersion)
    res:on("data", function(chunk)
      print("ondata", { chunk = chunk })
    end)
    res:on("end", function()
      print("stream ended")
      cb(res)
    end)
  end)
end

aget = a.wrap(get)
a.sync(function()
  print("aa")
  local res = a.wait(aget())
  p(res)
  print("bb")
end)()
