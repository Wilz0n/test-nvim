local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- <div className="">
  s("div", {
    t("<div className=\""), i(1), t("\">"),
    t({"", "  "}), i(0),
    t({"", "</div>"}),
  }),
}

