vim.g.projectionist_heuristics = {
  ["composer.json"] = {
    ["src/*.php"] = {
      type = "source",
      alternate = "tests/{}Test.php",
    },

    ["src/Controller/*.php"] = {
      type = "controller",
    },

    ["src/Model/*.php"] = {
      type = "model",
    },

    ["src/Service/*.php"] = {
      type = "service",
    },

    ["tests/*Test.php"] = {
      type = "test",
      alternate = "src/{}.php",
    },
  },

  ["package.json"] = {
    ["src/*.ts"] = {
      type = "source",
      alternate = "tests/{}.test.ts",
    },

    ["src/*.service.ts"] = {
      type = "source",
      alternate = "tests/{}.test.ts",
    },

    ["tests/*.test.ts"] = {
      type = "test",
      alternate = "src/{}.ts",
    },
  },
}
