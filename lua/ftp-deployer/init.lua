local M = {}

function M:setup()
    local command_opts = {
        desc = "descrição de teste",
    }
    vim.api.nvim_create_user_command("FtpDownload", function ()
        local Client = require("ftp-deployer.ftp_client")

        Client:download(vim.fn.expand("%:."))

    end, command_opts)

    vim.api.nvim_create_user_command("FtpUpload", function ()
        local Client = require("ftp-deployer.ftp_client")

        Client:upload(vim.fn.expand("%:."))

    end, command_opts)
end

return M

