local M = {}

--- @param input string
--- @return string
function UrlEncode(input)
  local result = string.gsub(input, "[^A-Za-z0-9_.-]", function(c)
    return string.format("%%%02X", string.byte(c))
  end)

  return result
end

function M.get()
  local apiKey = os.getenv("SA_KEY")
  local resource = UrlEncode("user/recentAttributes")
  local url = "https://localhost:8080/dispatch.php?v=get&r=" .. resource .. "&k=" .. apiKey

  vim.system({
    "curl",
    "-s",
    "-H",
    "'Content-Type: application/json'",
    "-X",
    "POST",
    url,
  }, { text = true }, function(out)
    vim.schedule(function()
      if out.code ~= 0 then
        vim.notify("ERROR" .. vim.inspect(url), vim.log.levels.ERROR)
        return
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)

      local lines = vim.split(out.stdout, "\n", { plain = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    end)
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("SaGet", M.get, {})
  -- vim.api.nvim_buf_create_user_command(0, "SaGet", M.get, {})
end

return M
