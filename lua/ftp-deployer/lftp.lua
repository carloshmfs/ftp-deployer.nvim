local LFTP = {}

LFTP.__index = LFTP

local function make_cmd(cmd, host, user, password)
    return "lftp", {
        "-e",
        "'set ssl:verify-certificate no; open ftp://" .. user .. ":" .. password .. "@" .. host .. "; " .. cmd .. " '",
    }
end

function LFTP.new(host, port, user, password)
    local self = setmetatable({}, LFTP)
    self.host = host
    self.port = port
    self.user = user
    self.password = password
    return self
end

function LFTP:put()
end

function LFTP:get(remote_file)
    local cmd, args   = make_cmd("cat " .. remote_file, self.host, self.user, self.password)
    local stdin       = vim.uv.new_pipe()
    local stdout      = vim.uv.new_pipe()
    local stderr      = vim.uv.new_pipe()
    local opts        = {
        args = args,
        stdio = { stdin, stdout, stderr },
    }

    local handle, pid = vim.uv.spawn(cmd, opts, function(code, signal)
        -- print("exit code: " .. code .. " exit signal: " .. signal)
        vim.notify("[FtpDeployer] an error ocurred while opening the lftp process", vim.log.levels.ERROR)
    end)

    vim.uv.read_start(stdout, function(err, data)
        assert(not err, err)
        if data then
            -- print("stdout chunk", stdout, data)
            return
        end
        -- print("stdout end", stdout)
    end)

    vim.uv.shutdown(stdin, function()
        -- print("stdin shutdown", stdin)
        vim.uv.close(handle, function()
            -- print("process closed", handle, pid)
        end)
    end)
end

function LFTP:cat()
end

return LFTP
