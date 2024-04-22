return {
        "iabdelkareem/csharp.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "Tastyep/structlog.nvim",
        },
        config = function()
            require("csharp").setup()
        end,
    enabled =false
}
