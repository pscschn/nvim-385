local M = {}

function M.pwd()
  local source = debug.getinfo(2, "S").source
  if source:sub(1, 1) == "@" then
      source = source:sub(2)
  end
  local full_path = vim.fn.fnamemodify(source, ":p")
  local dir_path = vim.fn.fnamemodify(full_path, ":h")
  return dir_path
end

function M.lsmods(module_dir)
  local modules = {}
  for dir in io.popen('ls -p ' .. module_dir .. ' | grep /$ | sed \'s/\\/$//\''):lines() do
    local init_dir = module_dir .. '/' .. dir  .. '/init'
    local init_file = io.open(init_dir, "r")
    if init_file then
      init_file:close()
      table.insert(modules  .. '/init')
    end
  end
  return modules
end

function M.loadsubmodules(module_dir)
  local modules = {}

  for dir in io.popen('ls -p ' .. module_dir .. ' | grep /$ | sed \'s/\\/$//\''):lines() do
      local module_init = module_dir .. '/' .. dir  .. '/init'
      local success, module = pcall(dofile, module_init .. '.lua')
      if success then
          table.insert(modules, module)
      else
          print('Error loading module: ', module_init)
      end
  end
  return modules
end

return M
