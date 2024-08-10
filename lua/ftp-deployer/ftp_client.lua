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

    print(path)

    local result = {}
    local response, error = ftp.get({
        host = config.host,
        sink = ltn12.sink.table(result),
        port = config.port,
        user = config.user,
        password = config.password,
        path = path
    })

    print(response, error)

    local file_contents = ""
    for _, chunk in ipairs(result) do
        file_contents = file_contents .. chunk
    end

    print(file_contents)
end

function FtpClient:upload(file)
end

return FtpClient

