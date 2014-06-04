;; Ruby

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)

;(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(setq auto-mode-alist
      (append '(
				("\\.rb$" . enh-ruby-mode)
				)  auto-mode-alist))

(add-hook 'enh-ruby-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)
						(flycheck-mode t)
						(ruby-electric-mode t)
						))

;(autoload 'rubydb "rubydb3x" "run rubydb on program file in buffer" t)
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; definition for flycheck
(flycheck-define-checker ruby-rubylint
  "A Ruby syntax and style checker using the rubylint tool."
  :command ("ruby-lint" source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
  :modes (enh-ruby-mode ruby-mode))
