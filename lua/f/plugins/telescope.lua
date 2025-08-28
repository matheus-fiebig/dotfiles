return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                file_ignore_patterns = {
                    "node_modules/.*",
                    "%.env",
                    "yarn.lock",
                    "package-lock.json",
                    "lazy-lock.json",
                    "target/.*",
                    "%.uid"
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "ignore_case",
                },
                ["ui-select"] = require("telescope.themes").get_dropdown {}
            },
            pickers = {
                find_files = {
                    theme = "ivy",
                },
                commands = {
                    theme = "ivy",
                },
                live_grep = {
                    theme = "ivy",
                },
                git_status = {
                    theme = "ivy",
                },
                trouble = {
                    theme = "ivy",
                }
            },
        })

        telescope.load_extension("ui-select")
    end,
}
