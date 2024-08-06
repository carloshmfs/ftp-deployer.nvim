local FtpClient = {}

function FtpClient:download(file)
end

function FtpClient:upload(file)
    local ftp = require("socket.ftp")
    print(ftp.get("ftp://test.rebex.net/readme.txt"))
end

function FtpClient:open_connection(file)
end

return FtpClient

