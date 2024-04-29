-- https://github.com/Rykaar/Vim-inoremaps-for-GNU-APL/blob/main/aplkeyboard.txt
--
--APL Keyboard
--
--╔════╦════╦════╦════╦════╦════╦════╦════╦════╦════╦════╦════╦════╦═════════╗
--║ ~  ║ !⌶ ║ @⍫ ║ #⍒ ║ $⍋ ║ %⌽ ║ ^⍉ ║ &⊖ ║ *⍟ ║ (⍱ ║ )⍲ ║ _! ║ +⌹ ║         ║
--║ `◊ ║ 1¨ ║ 2¯ ║ 3< ║ 4≤ ║ 5= ║ 6≥ ║ 7> ║ 8≠ ║ 9∨ ║ 0∧ ║ -× ║ =÷ ║ BACKSP  ║
--╠════╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦═╩══╦══════╣
--║       ║ Q  ║ W⍹ ║ E⋸ ║ R  ║ T⍨ ║ Y¥ ║ U  ║ I⍸ ║ O⍥ ║ P⍣ ║ {⍞ ║ }⍬ ║  |⊣  ║
--║  TAB  ║ q? ║ w⍵ ║ e∈ ║ r⍴ ║ t∼ ║ y↑ ║ u↓ ║ i⍳ ║ o○ ║ p⋆ ║ [← ║ ]→ ║  \⊢  ║
--╠═══════╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩═╦══╩══════╣
--║ (CAPS   ║ A⍶ ║ S  ║ D  ║ F  ║ G  ║ H  ║ J⍤ ║ K  ║ L⌷ ║ :≡ ║ "≢ ║         ║
--║  LOCK)  ║ a⍺ ║ s⌈ ║ d⌊ ║ f_ ║ g∇ ║ h∆ ║ j∘ ║ k' ║ l⎕ ║ ;⍎ ║ '⍕ ║ RETURN  ║
--╠═════════╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═══╦╩═════════╣
--║             ║ Z  ║ Xχ ║ C¢ ║ V  ║ B£ ║ N  ║ M  ║ <⍪ ║ >⍙ ║ ?⍠ ║          ║
--║  SHIFT      ║ z⊂ ║ x⊃ ║ c∩ ║ v∪ ║ b⊥ ║ n⊤ ║ m| ║ ,⍝ ║ .⍀ ║ /⌿ ║  SHIFT   ║
--╚═════════════╩════╩════╩════╩════╩════╩════╩════╩════╩════╩════╩══════════╝
--
--Usage: mark (single) APL characters here and copy/paste them into,
--for example, the APL input: input field of a try-GNU-APL window.
local function imap(lhs, rhs)
  vim.keymap.set('i', lhs, rhs)
end

imap('``', '◊')
imap('`1', '¨')
imap('`!', '⌶')
imap('`2', '¯')
imap('`@', '⍫')
imap('`3', '<')
imap('`#', '⍒')
imap('`4', '≤')
imap('`$', '⍋')
imap('`5', '=')
imap('`%', '⌽')
imap('`6', '≥')
imap('`^', '⍉')
imap('`7', '>')
imap('`&', '⊖')
imap('`8', '≠')
imap('`*', '⍟')
imap('`9', '∨')
imap('`(', '⍱')
imap('`0', '∧')
imap('`)', '⍲')
imap('`-', '×')
imap('`_', '!')
imap('`=', '÷')
imap('`+', '⌹')
imap('`q', '?')
imap('`w', '⍵')
imap('`W', '⍹')
imap('`e', '∈')
imap('`E', '⋸')
imap('`r', '⍴')
imap('`t', '∼')
imap('`T', '⍨')
imap('`y', '↑')
imap('`Y', '¥')
imap('`u', '↓')
imap('`i', '⍳')
imap('`I', '⍸')
imap('`o', '○')
imap('`O', '⍥')
imap('`p', '⋆')
imap('`P', '⍣')
imap('`[', '←')
imap('`{', '⍞')
imap('`]', '→')
imap('`}', '⍬')
imap('`A', '⍶')
imap('`s', '⌈')
imap('`d', '⌊')
imap('`f', '_')
imap('`g', '∇')
imap('`h', '∆')
imap('`j', '∘')
imap('`J', '⍤')
imap('`k', "'")
imap('`l', '⎕')
imap('`L', '⌷')
imap('`;', '⍎')
imap('`:', '≡')
imap("`'", '⍕')
imap('`v', '∪')
imap('`b', '⊥')
imap('`B', '£')
imap('`n', '⊤')
imap('`m', '|')
imap('`,', '⍝')
imap('`<', '⍪')
imap('`.', '⍀')
imap('`>', '⍙')
imap('`c', '∩')
imap('`C', '¢')
imap('`/', '⌿')
imap('`X', 'χ')
imap('`|', '⊣')
imap('`a', '⍺')
imap('`z', '⊂')
imap('`?', '⍠')
imap('`x', '⊃')
imap('`"', '≢')
imap('`\\', '⊢')
-- vim.keymap.set("n", "<F1>", function()
--     local file = vim.fn.expand "%"
--     vim.api.nvim_command("!apl -f " .. file)
-- end)
