local FtpClient = {}

local ftp = require("socket.ftp")
local ltn12 = require("ltn12")

local config = {
    host = "127.0.0.1",
    port = "2211",
    user = "robott",
    password = "",
    base_remote_path = "/public_html/",
    base_local_path = "",
}

function FtpClient:download(file)
    local path = config.base_remote_path .. "test.php"

    print(path)

    local t = {}

    local response, error = ftp.get({
        host = config.host,
        sink = ltn12.sink.table(t),
        port = config.port,
        user = config.user,
        password = config.password,
        path = path
    })

    print(response, error, t[1])
end

function FtpClient:upload(self, file)
end

return FtpClient

