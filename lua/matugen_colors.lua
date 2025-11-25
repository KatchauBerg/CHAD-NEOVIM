return {
  -- === MUDANÇAS PARA FICAR PASTEL ===

  -- Antes era 'surface' (Preto forte). 
  -- Agora 'surface_container' é um cinza/azulado suave (depende da foto).
  background = "#1e1f25",

  -- Se quiser ainda mais claro (tipo um cinza médio), use:
  -- background = "#292a2f",

  -- Texto: Usar 'on_surface_variant' deixa o branco menos estourado (mais suave)
  foreground = "#e3e2e9", 

  -- Cursorline: Precisa ser um pouco diferente do background para destacar
  cursorline = "#292a2f",

  comment    = "#8f909a",

  -- Destaques (Mantém iguais)
  primary    = "#b4c4ff",
  secondary  = "#c1c5dd",
  tertiary   = "#e2bbdb",

  -- UI
  selection  = "#34343a", -- Seleção mais visível
  border     = "#45464f",
  error      = "#ffb4ab",
  warn       = "#e2bbdb",
}
