-- Post-install hooks for `vim.pack.add`.
--
-- These must be registered *before* vim.pack.add() runs: a first install fires
-- PackChanged during that call, so an autocmd created afterwards never sees it.
--
-- The work itself is deferred with vim.schedule: PackChanged fires *during*
-- vim.pack.add(), before any plugin's setup() has run, so :GoInstallDeps does
-- not exist yet at that point and running it inline aborts startup.

local function on_pack(name, fn)
    vim.api.nvim_create_autocmd("PackChanged", {
        pattern = "*",
        callback = function(ev)
            if ev.data.spec.name ~= name then return end
            if not vim.tbl_contains({ "install", "update" }, ev.data.kind) then return end
            vim.schedule(function()
                local ok, err = pcall(fn)
                if not ok then
                    vim.notify(("[%s] post-install hook failed: %s"):format(name, err), vim.log.levels.WARN)
                end
            end)
        end,
    })
end

on_pack("godoc.nvim", function()
    -- async: a blocking `go install` here would stall the first startup
    vim.system({ "go", "install", "github.com/lotusirous/gostdsym/stdsym@latest" }, {}, function(res)
        if res.code ~= 0 then
            vim.schedule(function()
                vim.notify("[godoc.nvim] stdsym install failed: " .. (res.stderr or ""), vim.log.levels.WARN)
            end)
        end
    end)
end)

on_pack("gopher.nvim", function()
    vim.cmd.GoInstallDeps()
end)
