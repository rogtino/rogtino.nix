;; extends
;; https://www.youtube.com/watch?v=8fCkt5qgHw8
; (
;  (function_call
;    (identifier) @require_call
;    (#match? @require_call "require")
;    )
;  (set! "priority" 105)
;  (#set! conceal "☄️")
; )

; (
;  (function_call
;    (identifier) @pairs
;    (#match? @pairs "pairs")
;    )
;  (set! "priority" 105)
;  )
;
; (function_declaration
;   (identifier)@function_definition
;   )
; (
;  (function_declaration
;    (dot_index_expression
;      (identifier)
;      (identifier)@function_definition
;      )
;    )
;  (set! "priority" 105)
;  )
;
; (
;  (assignment_statement
;    (variable_list
;      (identifier)@function_definition
;      )
;    (
;     expression_list
;     (function_definition)
;     )
;    )
;  (set! "priority" 105)
;  )
; (
;  (assignment_statement
;    (variable_list
;      (dot_index_expression
;        (identifier)
;        (identifier)@function_definition
;        )
;      )
;    (
;     expression_list
;     (function_definition)
;     )
;    )
;  (set! "priority" 105)
;  )
;
; (
;   (function_call
;     name: (identifier) @function.builtin
;     (#eq? @function.builtin "pairs")
;   )
;   (#set! conceal "P")
; )
;
(
  (function_call
    name: (identifier) @function.builtin
    (#eq? @function.builtin "ipairs")
  )
  (#set! conceal "I")
)

(
  (identifier) @function
  (#eq? @function "utils")
  (#set! conceal "")
  ; (#set! conceal "U")
)

; (
;   (dot_index_expression
;     table: (identifier) @keyword
;     (#eq? @keyword  "utils" )
;   )
;   (#set! conceal "U")
; )
;
; (
;   (dot_index_expression) @keyword
;     (#eq? @keyword  "vim.keymap.set" )
;   (#set! conceal "󰖷")
; )

(
  (dot_index_expression) @function
    (#eq? @function  "vim.cmd" )
  (#set! conceal ">")
)

; (
;   (dot_index_expression) @keyword
;     (#eq? @keyword  "vim.opt" )
;   (#set! conceal "opt")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "vim.keymap.set" )
;   (#set! conceal "󰌌")
; )

(("return" @keyword) (#set! conceal "󰌑"))
; (("local" @keyword) (#set! conceal "L"))
(("local" @keyword) (#set! conceal "ϑ"))
(("do" @keyword) (#set! conceal "…"))
(("function" @keyword) (#set! conceal "󰊕"))
(("then" @keyword) (#set! conceal "󰌒"))
(("not" @keyword) (#set! conceal "∉"))
(("end" @keyword) (#set! conceal "𝖊"))
(("for" @repeat) (#set! conceal "↬"))
(("while" @repeat) (#set! conceal ""))

; for -> circle arrow
(
  (break_statement)@keyword
  (#eq? @keyword  "break" )
  (#set! conceal "")
)
