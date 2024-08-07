local M = {}

function M:setup()
    local command_opts = {
        desc = "descrição de teste",
    }
    vim.api.nvim_create_user_command("FtpUpload", function ()
        local client = require("ftp-deployer.ftp_client").new()
        client.upload(vim.fn.expand("%:p"))

    end, command_opts)
end

return M

