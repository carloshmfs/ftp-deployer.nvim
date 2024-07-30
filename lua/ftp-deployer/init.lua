local utils = require("ftp-deployer.utils")

local M = {}

function M:setup()
    local command_opts = {
        desc = "descrição de teste",
        nargs = 1
    }
    vim.api.nvim_create_user_command("Ftp", function (command)

        -- local args = utils.split_string(command.args, "")
        local args = {}
        local sep = " "
        for word in string.gmatch(command.args, "([^"..sep.."]+)") do
            table.insert(args, word)
        end

        for index, arg in ipairs(args) do
            if index == 1 and arg == "upload" then
                local ftp = require("ftp-deployer.ftp_client").new({})
                ftp.upload("test.php")
            end
        end

    end, command_opts)
end

return M

