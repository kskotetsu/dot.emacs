;; Ruby
(require 'enh-ruby-mode)
(require 'flycheck)

;(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)

(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool.

See URL `http://batsov.com/rubocop/'."
  :command ("rubocop" "--format" "emacs" "--silent"
            (config-file "--config" flycheck-rubocoprc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
  :modes (enh-ruby-mode motion-mode ruby-mode))


(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (setq auto-mode-alist
;;       (append '(
;; 				("\\.rb$" . enh-ruby-mode)
;; 				)  auto-mode-alist))

(add-hook 'enh-ruby-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)
						(flycheck-mode t)
						(ruby-electric-mode t)
						(erm-define-faces)
						(set-face-foreground 'enh-ruby-op-face "gray40")
						(set-face-foreground 'enh-ruby-string-delimiter-face "gray40")
						))

;(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)

;(setq flycheck-rubocop-lint-only t)
;(setenv GEM_PATH "C:/Ruby193/lib/ruby/gems/1.9.1")

;(autoload 'rubydb "rubydb3x" "run rubydb on program file in buffer" t)
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

