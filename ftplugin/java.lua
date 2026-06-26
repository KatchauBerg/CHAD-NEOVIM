-- Per-buffer jdtls launch. Runs for every Java file.
if vim.g.vscode then
  return
end

local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local mason = vim.fn.stdpath("data") .. "/mason"

-- Project root: maven/gradle/git markers
local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end

-- Isolated workspace per project
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Debug + test bundles for nvim-dap
local bundles = {}
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
    "\n"
  )
)
vim.list_extend(bundles, vim.split(vim.fn.glob(mason .. "/packages/java-test/extension/server/*.jar", true), "\n"))

-- Spring Boot LSP bundles
local sb_ok, spring_boot = pcall(require, "spring_boot")
if sb_ok then
  vim.list_extend(bundles, spring_boot.java_extensions())
end

-- jdtls installed manually (Eclipse removed the milestone URL Mason uses)
local jdtls_bin = vim.fn.stdpath("data") .. "/jdtls/bin/jdtls"

local config = {
  cmd = { jdtls_bin, "-data", workspace_dir },
  root_dir = root_dir,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  init_options = { bundles = bundles },
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      configuration = {
        -- Add JDK paths here if you run multiple versions:
        -- runtimes = { { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk-amd64" } },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
    },
  },
}

jdtls.start_or_attach(config)

-- Wire java DAP into existing nvim-dap-ui
jdtls.setup_dap({ hotcodereplace = "auto" })

if sb_ok then
  spring_boot.init_lsp_commands()
end
