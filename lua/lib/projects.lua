local M = {}

function M.load_settings()
  local config_path = "./.nvim/settings.lua"

  local file = io.open(config_path, "r")
  if file == nil then
    return nil
  end

  file:close()
  vim.cmd(":luafile " .. config_path)
end

return M
