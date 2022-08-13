--lua/keys/n.lua - key mapping for normal mode

vim.keymap.set("n", "u", "<cmd>undo<cr>", {
    ["remap"] = false,
    ["desc"] = "revert the last action",
})
vim.keymap.set("n", "U", "<cmd>redo<cr>", {
    ["remap"] = false,
    ["desc"] = "revert the last undo",
})

vim.keymap.set("n", "fe", "<cmd>Explore<cr>", {
    ["remap"] = false,
    ["desc"] = "focus on file explorer",
})
vim.keymap.set("n", "ft", "<cmd>split term://$SHELL<cr>", {
    ["remap"] = false,
    ["desc"] = "focus on integrated terminal",
})

vim.keymap.set("n", "fc", "<cmd>Telescope commands<cr>", {
    ["remap"] = false,
    ["desc"] = "fuzzy find a command",
})
vim.keymap.set("n", "ff", "<cmd>Telescope find_files<cr>", {
    ["remap"] = false,
    ["desc"] = "fuzzy find a file",
})
vim.keymap.set("n", "fg", "<cmd>Telescope live_grep<cr>", {
    ["remap"] = false,
    ["desc"] = "fuzzy find an expression in files",
})
vim.keymap.set("n", "fb", "<cmd>Telescope buffers<cr>", {
    ["remap"] = false,
    ["desc"] = "fuzzy find an openned buffer",
})

vim.keymap.set("n", "T", "<cmd>tabnew<cr>", {
    ["remap"] = false,
    ["desc"] = "open a new tab",
})
vim.keymap.set("n", "gt", "<cmd>tabn<cr>", {
    ["remap"] = false,
    ["desc"] = "switch to the next tab",
})
vim.keymap.set("n", "gT", "<cmd>tabp<cr>", {
    ["remap"] = false,
    ["desc"] = "switch to the prev tab",
})

vim.keymap.set("n", "gb", "<cmd>bn<cr>", {
    ["remap"] = false,
    ["desc"] = "switch to the next buffer",
})
vim.keymap.set("n", "gB", "<cmd>bp<cr>", {
    ["remap"] = false,
    ["desc"] = "switch to the prev buffer",
})

vim.keymap.set("n", "!", ":! ", {
    ["remap"] = false,
    ["desc"] = "switch to the prev buffer",
})

--endf
