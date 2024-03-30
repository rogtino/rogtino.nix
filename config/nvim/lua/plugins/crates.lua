return {
	"Saecki/crates.nvim",
	event = "BufRead Cargo.toml",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local crates = require("crates")
		vim.keymap.set({ "n" }, "ct", crates.toggle)
		vim.keymap.set({ "n" }, "cr", crates.reload)
		vim.keymap.set({ "n" }, "cv", crates.show_versions_popup)
		vim.keymap.set({ "n" }, "cf", crates.show_features_popup)
		vim.keymap.set({ "n" }, "cu", crates.update_crate)
		vim.keymap.set({ "n" }, "ca", crates.update_all_crates)
		vim.keymap.set({ "n" }, "cU", crates.upgrade_crate)
		vim.keymap.set({ "n" }, "cA", crates.upgrade_all_crates)
		vim.keymap.set({ "v" }, "cU", crates.upgrade_crates)
		vim.keymap.set({ "v" }, "cu", crates.update_crates)
		require("crates").setup()
	end,
}
