return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node

    ls.add_snippets("lua", {
      s("sop", {
        t("System.out.println();"),
      }),
	  s("psvm", {
		  t("public static void main(String[] args) {};")
	  }),
    })

    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/luasnip.lua" })
  end
}

