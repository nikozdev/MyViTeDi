--lua/plug/glow.lua - markdown preview

local dap = require("dap")

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/nikozdev/.local/share/"
    .. "cpptools/extension/debugAdapters/bin/OpenDebugAD7",
} -- dap.adapters.cppdbg

dap.setupCommands = {
} -- dap.setupCommands

dap.configurations.cpp = {
    {
        name = "launch",
        type = "cppdbg",
        request = "launch",
        program = function()
            local prompt = vim.fn.getcwd() .. "/bin/"
            return vim.fn.input("execpath: ", prompt, "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
    },
    {
        name = "attach",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        program = function()
            local prompt = vim.fn.getcwd() .. "/bin/"
            return vim.fn.input("execpath: ", prompt, "file")
        end,
        cwd = "${workspaceFolder}",
    },
} -- dap.configurations.cpp

--dap
