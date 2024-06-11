return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    opts = function()
      -- calculate workspace dir
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      os.execute("mkdir " .. workspace_dir)

      -- get the mason install path
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

      -- get the current OS
      local os
      if vim.fn.has "mac" == 1 then
        os = "mac"
      elseif vim.fn.has "unix" == 1 then
        os = "linux"
      elseif vim.fn.has "win32" == 1 then
        os = "win"
      end

      return {
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. install_path .. "/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          install_path .. "/config_" .. os,
          "-data",
          workspace_dir,
        },
        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
        settings = {
          java = {},
        },
        init_options = {
          bundles = {},
        },
      }
    end,
    config = function(_, opts)
      require("jdtls").start_or_attach(opts)
    end,
  },
}
