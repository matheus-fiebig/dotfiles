local M = {}

function M:get_occupied_tcp_ports()
    local occupied_ports = {}
    local command
    local os_type

    if package.config:sub(1, 1) == '\\' then
        os_type = "Windows"
        command = "netstat -an"
    else
        os_type = "Unix"
        command = "netstat -ltn"
    end

    local handle = io.popen(command)
    if not handle then
        print("Erro: Não foi possível executar o comando 'netstat'.")
        return nil
    end

    for line in handle:lines() do
        local port

        if os_type == "Windows" then
            if line:find("TCP") and line:find("LISTENING") then
                port = line:match(":%d+")
                if port then
                    port = port:sub(2) -- Remove o ":" inicial
                    occupied_ports[tonumber(port)] = true
                end
            end
        else
            port = line:match(":%d+%s")
            if port then
                port = port:match("%d+")
                occupied_ports[tonumber(port)] = true
            end
        end
    end

    handle:close()
    return occupied_ports
end

-- Função que usa a lista de portas ocupadas para encontrar uma livre
function M:find_free_port(start_port, end_port)
    local occupied = self:get_occupied_tcp_ports()
    if not occupied then return nil end

    for port = start_port, end_port do
        if not occupied[port] then
            return port
        end
    end

    return nil
end

return M
