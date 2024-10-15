local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "gopls" }

-- lsps with default config
for _, l in ipairs(servers) do
  lspconfig[l].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Without the loop, you would have to manually set up each LSP 
-- 
-- l.html.setup {
--   on_attach = nvlsp.on_attach,
--   capabilities = nvlsp.capabilities,
-- }
