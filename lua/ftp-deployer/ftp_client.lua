local FtpClient = {}

local ftp = require("socket.ftp")

local config = {
    host = "ftp.127.0.0.1",
    port = "2211",
    user = "robott",
    password = "",
    base_path = "",
}

function FtpClient:download(file)
    local path = config.base_path .. "/artisan"

    local response, error = ftp.get({
        host = config.host,
        port = config.port,
        user = config.user,
        password = config.password,
        path = path
    })

    print(response, error)
end

function FtpClient:upload(self, file)
end

return FtpClient

