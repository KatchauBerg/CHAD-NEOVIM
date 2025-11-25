return {
  -- === MUDANÇAS PARA FICAR PASTEL ===

  -- Antes era 'surface' (Preto forte). 
  -- Agora 'surface_container' é um cinza/azulado suave (depende da foto).
  background = "#241e23",

  -- Se quiser ainda mais claro (tipo um cinza médio), use:
  -- background = "#2e282d",

  -- Texto: Usar 'on_surface_variant' deixa o branco menos estourado (mais suave)
  foreground = "#ebdfe6", 

  -- Cursorline: Precisa ser um pouco diferente do background para destacar
  cursorline = "#2e282d",

  comment    = "#998d96",

  -- Destaques (Mantém iguais)
  primary    = "#eeb4e9",
  secondary  = "#d9bfd4",
  tertiary   = "#f6b8aa",

  -- UI
  selection  = "#393338", -- Seleção mais visível
  border     = "#4d444b",
  error      = "#ffb4ab",
  warn       = "#f6b8aa",
}
