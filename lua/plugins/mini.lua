return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    local files = require("mini.files")

    require("mini.ai")
    require("mini.comment").setup({
      mappings = {
        comment = "<leader>/",
        comment_line = "<leader>/",
        comment_visual = "<leader>/",
      },
    })
    files.setup({
      options = {
        use_as_default_explorer = false,
      },
    })
    require("mini.move").setup()
    require("mini.notify").setup()
    require("mini.pairs").setup()
    require("mini.starter").setup({
      header = [[
.. ..  .  .  .. :.  .  .  .. ..  . 
  .  .. .. :.........    .  .  .. .
  .  .. ;:::::::::::.....   .  .. .
.. .. X;;::::::::::.........  .  . 
  .  XXXXX:::$::::.....$.....  .. .
  : $XXXXX$::&&:::::..$X.....   . .
.. +;XXXXXX:x&&:::::::XX......   . 
  :+;;;$X$;;:$::::::::&$.......  ..
 .;++;;;;;;:;::X::::::::::::::.   .
.;;+++;;;;;;;;;::::::::::::::::    
 :;x++;;;;;;;;;;;::::::::::::::.. .
 .+;+++;X&&;;;;;;;;::::::&$:::::. .
..;+x++++;;$;;;;;;;;;;::&::::::: . 
  .;+;x++++;;$&&&xx&&&&;::::::::. .
.. .:+xxx++++;;;;;;;;;;;;;;;;..  . 
.. .. :x++x+++++++;;;;;;;;+; ..  . 
  .  .. .;+xX+xxx++++++X;.  .  .. .
.. ..  .  .  .:.;;...  .  .. :.  . 

      ]],
    })
    require("mini.statusline").setup()
    require("mini.surround").setup()
    vim.keymap.set("n", "<leader>e", files.open, { desc = "Opens file browser" })
  end,
}
