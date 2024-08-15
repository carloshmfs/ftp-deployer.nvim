local FtpClient = {}

local ftp = require("socket.ftp")
local ltn12 = require("ltn12")
local json = require("libs.json")

local CONFIG_FILE_NAME = "ftp-deployer.json"

local function get_config()
    local file_path = vim.loop.cwd() .. "/" .. CONFIG_FILE_NAME
    local file = io.open(file_path, "r")

    if file == nil then
        print("config file not found")
        return {}
    end

    local file_contents = ""
    for line in file:lines() do
        file_contents = file_contents .. line
    end

    return json.decode(file_contents)
end

function FtpClient:download(file)
    local config = get_config()
    local path = config.base_remote_path .. file

    local result = {}
    local response, error = ftp.get({
        host = config.host,
        sink = ltn12.sink.table(result),
        port = config.port,
        user = config.user,
        password = config.password,
        path = path
    })

    local file_contents = {}
    for _, chunk in ipairs(result) do
        for line in chunk:gmatch("([^\r\n]*)\r?\n?") do
            table.insert(file_contents, line)
        end
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, file_contents)
end

function FtpClient:upload(file)
    local config = get_config()
    local path = config.base_remote_path .. file

    local response, error = ftp.get({
        host = config.host,
        port = config.port,
        user = config.user,
        password = config.password,
        sink = ltn12.source.file(io.open(path, "r")),
        command = "appe",
    })

    print(response, error)
end

return FtpClient

