;; extends
(
 function_item
 (
  identifier
  )@function_definition
 )


(("->" @operator) (#set! conceal "►"))
(("fn" @keyword.function) (#set! conceal "󰊕"))
(("impl" @keyword) (#set! conceal "𝛻"))
(("pub" @keyword) (#set! conceal "𝓟"))
(("struct" @keyword) (#set! conceal "𝓢"))
(("enum" @keyword) (#set! conceal "𝓔"))

(("use"    @keyword) (#set! conceal "☔"))
(("return" @keyword) (#set! conceal "◄"))
(("break" @keyword) (#set! conceal ""))
(("!" @keyword) (#set! conceal "󰛕"))
; (scoped_identifier(scoped_identifier path: (scoped_identifier) @rust_path) (#set! conceal "󰏗"))
; (scoped_identifier(scoped_identifier path: (identifier) @rust_path) (#set! conceal "󰏗"))
