--- mini clue (which-key style hotkey hints) ---
local MiniClue = require("mini.clue")

MiniClue.setup({
    triggers = {
        { mode = "n", keys = "<leader>" },
        { mode = "x", keys = "<leader>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        -- mini.surround's prefix. Only the trigger is needed: mini.surround
        -- already sets `desc` on sa/sd/sr/sf/sF/sh/sn, so clue reads those.
        { mode = "n", keys = "s" },
        { mode = "x", keys = "s" },
        -- insert mode: these make gen_clues.builtin_completion() and the
        -- insert half of gen_clues.registers() reachable
        { mode = "i", keys = "<C-x>" },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
    },
    clues = {
        MiniClue.gen_clues.builtin_completion(),
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),

        -- mini.align takes over `ga`/`gA`; gen_clues.g() above still labels
        -- them "Print ascii value", so correct that here (later clue wins).
        { mode = "n", keys = "ga", desc = "Align" },
        { mode = "x", keys = "ga", desc = "Align" },
        { mode = "n", keys = "gA", desc = "Align with preview" },
        { mode = "x", keys = "gA", desc = "Align with preview" },

        -- name the <leader> groups so the popup reads "+pick" not "+3 choices"
        { mode = "n", keys = "<leader>c", desc = "+code" },
        { mode = "n", keys = "<leader>g", desc = "+git/goto" },
        { mode = "n", keys = "<leader>go", desc = "+go" },
        { mode = "n", keys = "<leader>m", desc = "+markdown" },
        { mode = "n", keys = "<leader>p", desc = "+pick" },
        { mode = "n", keys = "<leader>r", desc = "+refactor" },
        { mode = "n", keys = "<leader>t", desc = "+test/debug" },
        { mode = "n", keys = "<leader>v", desc = "+vim" },
        { mode = "n", keys = "<leader>x", desc = "+diagnostics" },
    },
    window = {
        delay = 300,
    },
})
