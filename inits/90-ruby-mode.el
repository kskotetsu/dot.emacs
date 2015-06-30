;; Ruby

;; robe-modeを使うには次のgemが必要
;;   gem install pry pry-doc method_source
;; rubyファイルを開いてから M-x inf-ruby, M-x robe-start

;; rcodetoolsを使うには次のgemが必要
;;   gem rcodetools fastri



(require 'enh-ruby-mode)
(require 'flycheck)
(require 'inf-ruby)

;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;                        (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;(defvar ruby-program-name "irb1.9 --inf-ruby-mode"
;  "*Program invoked by the run-ruby command")


(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool.

See URL `http://batsov.com/rubocop/'."
  :command ("rubocop" "--format" "emacs"
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

;(setq flycheck-rubocop-lint-only t)

(add-to-list 'auto-mode-alist
			 '("\\.rb$" . ruby-mode)
			 '("Rakefile" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; (setq auto-mode-alist
;;       (append '(
;; 				("\\.rb$" . enh-ruby-mode)
;; 				)  auto-mode-alist))

(defun my-ruby-mode ()
  (require 'rcodetools)
  (require 'robe)
  (require 'ac-robe)
  (require 'ruby-block)
  ; (rcodetools)
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
  (inf-ruby-minor-mode t)
  (setq ruby-block-highlight-toggle 'overlay)
  (erm-define-faces)
  (robe-mode)
  (robe-ac-setup)
										;(inf-ruby)
										;(inf-ruby-minor-mode)
  (set-face-foreground 'enh-ruby-op-face "gray40")
  (set-face-foreground 'enh-ruby-string-delimiter-face "gray40")
  )

(add-hook 'ruby-mode-hook 'my-ruby-mode)

;(remove-hook 'enh-ruby-mode-hook 'erm-define-faces)


;(autoload 'rubydb "rubydb3x" "run rubydb on program file in buffer" t)
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

; robe
;(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
;;(autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
;(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(setenv "PAGER" (executable-find "cat"))

;(push 'ac-source-robe ac-sources)
