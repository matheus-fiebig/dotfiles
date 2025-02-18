return {
    "gelguy/wilder.nvim",
    config = function()
        local wilder = require("wilder")
        wilder.setup({ modes = { ":", "/", "?" } })
        wilder.set_option('use_python_remote_plugin', 0)

        wilder.set_option("pipeline", {
            wilder.branch(
                wilder.cmdline_pipeline({
                    fuzzy = 1,
                }),
                wilder.vim_search_pipeline({
                    fuzzy = 1,
                })
            ),
        })

        wilder.set_option(
            "renderer",
            wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                highlighter = wilder.basic_highlighter(),
                pumblend = 5,
                min_width = "100%",
                min_height = "25%",
                max_height = "35%",
                border = "rounded",
                left = { " ", wilder.popupmenu_devicons() },
                right = { " ", wilder.popupmenu_scrollbar() },
            }))
        )

        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_palette_theme({
                border = 'rounded',
                max_height = '25%', -- max height of the palette
                min_height = 0, -- set to the same as 'max_height' for a fixed height window
                prompt_position = 'bottom', -- 'top' or 'bottom' to set the location of the prompt
                reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
            })
        ))
    end

}
