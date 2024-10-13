return {
   "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        vim.notify = notify

        notify.setup({
            background_colour = "NotifyBackground",
            fps = 90,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 1,
            minimum_width = 50,
            render = "compact",
            stages = "slide",
            time_formats = {
                notification = "%T",
                notification_history = "%FT%T"
            },
            timeout = 2000,
            top_down = true
        })
    end
}

