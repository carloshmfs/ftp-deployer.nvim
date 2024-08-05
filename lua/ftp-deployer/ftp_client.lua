local FtpClient = {}

function FtpClient:download(file)
end

function FtpClient:upload(file)
    local ftp = require("socket.ftp")
    print(file)
end

function FtpClient:open_connection(file)
end

return FtpClient

