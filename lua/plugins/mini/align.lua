--- mini align ---
-- `ga` to align, `gA` to align with an interactive preview. Both take a
-- motion/textobject first, e.g. `gaip=` aligns the paragraph on `=`.
-- Note: this takes over `ga`, which is otherwise "print ascii value" (`:h ga`).
require("mini.align").setup()
