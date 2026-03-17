local M = {}

function M.get_github_link(opts)
  local remote = vim.fn.system("git remote get-url origin 2>/dev/null"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then return nil end

  local org, repo = remote:match("github%.com[:/]([^/]+)/(.-)%.?git$")
  if not org then return nil end

  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
  local root   = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  local rel    = vim.fn.expand("%:p"):gsub("^" .. vim.pesc(root) .. "/", "")

  local base = ("https://github.com/%s/%s/blob/%s/%s"):format(org, repo, branch, rel)
  if opts and opts.line1 then
    if opts.line2 and opts.line2 ~= opts.line1 then
      return base .. ("#L%d-L%d"):format(opts.line1, opts.line2)
    else
      return base .. ("#L%d"):format(opts.line1)
    end
  end
  return base
end

return M
