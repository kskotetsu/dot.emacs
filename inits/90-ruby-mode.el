;; Ruby
(require 'enh-ruby-mode)
(require 'flycheck)

;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;                        (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))


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
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; (setq auto-mode-alist
;;       (append '(
;; 				("\\.rb$" . enh-ruby-mode)
;; 				)  auto-mode-alist))

(add-hook 'ruby-mode-hook
		  '(lambda()
			 (require 'rcodetools)
			 (require 'robe)
			 (require 'ac-robe)
			 (require 'ruby-block)

;			 (rcodetools)
			 (define-key ruby-mode-map (kbd "C-c C-d") 'xmp)
			 (setq indent-tabs-mode nil)
			 (setq indent-level 4)
			 (setq python-indent 4)
			 (setq tab-width 4)
			 (flycheck-mode t)
			 (highlight-symbol-mode t)
			;(ruby-electric-mode t)
			 (ruby-end-mode)
			 (electric-pair-mode t)
			 (electric-indent-mode t)
			 (electric-layout-mode t)
			 (ruby-block-mode t)
			 (setq ruby-block-highlight-toggle t)
			 (setq ruby-block-highlight-toggle 'overlay)
			 (erm-define-faces)
;			 (set-face-foreground 'enh-ruby-op-face "gray40")
;			 (set-face-foreground 'enh-ruby-string-delimiter-face "gray40")
			 (robe-mode)
			 (robe-start)
			 ;(inf-ruby)
			 ;(inf-ruby-minor-mode)
			 ))

;(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)

;(setq flycheck-rubocop-lint-only t)
;(setenv GEM_PATH "C:/Ruby193/lib/ruby/gems/1.9.1")

;(autoload 'rubydb "rubydb3x" "run rubydb on program file in buffer" t)
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

; robe
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
;(autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(setenv "PAGER" (executable-find "cat"))

(push 'ac-source-robe ac-sources)
(add-hook 'robe-mode-hook
		  '(lambda()
			 (robe-ac-setup)
			 (robe-start)
			 ))

(add-hook 'robe-mode-hook 'ac-robe-setup)
