;; extends
(
 function_definition
 (function_declarator
   (
    identifier
    )@function_definition
   )
 )
; (((declaration type: (primitive_type) @type) (#eq? @type "char")) (#set! conceal "c"))
; (((declaration (type_qualifier) @keyword) (#eq? @keyword "const")) (#set! conceal "🏅"))
(("const" @keyword) (#set! conceal ""))
(("->" @operator) (#set! conceal "►"))
(("struct" @keyword) (#set! conceal "𝓢"))
(("enum" @keyword) (#set! conceal "𝓔"))
;
; (("include"    @keyword) (#set! conceal "☔"))
(("using"    @keyword) (#set! conceal "☔"))
; (("pubic" @keyword) (#set! conceal "𝓟"))
(("return" @keyword) (#set! conceal "◄"))
(("break" @keyword) (#set! conceal "𝓑"))
(("!" @keyword) (#set! conceal "󰛕"))
