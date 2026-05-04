--- SimplyAnalytics API NeoVim Plugin
--- An experimental plugin which allows for querying and inspecting API
--- responses back from the API directly in NeoVim.
---
--- Optionally will send the JSON buffer contents as the request body.

local new_cmd = vim.api.nvim_create_user_command

--- @param input string
--- @return string
local function url_encode(input)
  local result = string.gsub(input, "[^A-Za-z0-9_.-]", function(c)
    return string.format("%%%02X", string.byte(c))
  end)

  return result
end

--- @alias verb
--- | "get"
--- | "post"
--- | "create"
--- | "delete"
--- | "find"
--- | "regenerate"
--- | "update"
--- @param v verb
--- @param r string
local function request(v, r)
  local api_key = os.getenv("SA_KEY")

  if not api_key then
    vim.notify("SA_KEY environment variable not found", vim.log.levels.WARN)
    return
  end

  r = url_encode(r)
  local url = string.format("https://localhost:8080/dispatch.php?v=%s&r=%s&k=%s", v, r, api_key)
  local filetype = vim.fn.expand("%:e")
  local body_str = ""

  if filetype == "json" then
    local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local body = table.concat(content, "")

    if body ~= nil then
      body_str = " -d '" .. body .. "'"
    end
  end

  --- @param out vim.SystemCompleted
  local on_exit = function(out)
    if out.code ~= 0 then
      vim.notify("ERROR" .. vim.inspect(url), vim.log.levels.ERROR)
      return
    end

    vim.schedule(function()
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      vim.bo[buf].filetype = "json"

      local lines = vim.split(out.stdout, "\n", { plain = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    end)
  end

  vim.system({
    "sh",
    "-c",
    string.format("curl -s -H 'Content-Type: application/json' -X POST%s '%s' | jq", body_str, url),
  }, { text = true }, on_exit)
end

local M = {}

--- @param opts vim.api.keyset.create_user_command.command_args
function M.get(opts)
  request("get", opts.args)
end

--- @param opts vim.api.keyset.create_user_command.command_args
function M.find(opts)
  request("find", opts.args)
end

function M.setup()
  new_cmd("SaGet", M.get, {
    nargs = "*",
    range = true,
    complete = function()
      return {
        "attributes",
        "data/locations2",
        "institution",
        "system",
        "user",
        "user/customAttributes",
        "user/customLocations",
        "user/data",
        "user/projects",
        "user/recentAttributes",
      }
    end,
  })

  new_cmd("SaFind", M.find, {
    nargs = "*",
    range = true,
    complete = function()
      return {
        "data/locations2",
      }
    end,
  })
end

return M
