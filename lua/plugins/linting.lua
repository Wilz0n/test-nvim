return {
  "mfussenegger/nvim-lint",
  opts = {
    -- Eventos que disparan el chequeo (al guardar, al insertar texto, etc.)
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      sql = { "squawk" },
    },
  },
}
