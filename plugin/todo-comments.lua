vim.pack.add({
	"https://github.com/folke/todo-comments.nvim",
})

Todo = require("todo-comments")
Todo.setup({
	signs = true,
})