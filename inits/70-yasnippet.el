;(el-get 'sync 'yasnippet)
(require 'yasnippet)

(add-to-list 'yas-snippet-dirs
      "~/.emacs.d/snippets")

(custom-set-variables '(yas-trigger-key "TAB"))
;(yas/load-directory "~/.emacs.d/snippets/ruby-mode")
(yas-global-mode)

(eval-after-load "yasnippet"
  '(progn
     ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
     (define-key yas-keymap (kbd "<tab>") nil)
     (yas-global-mode 1)))

;(el-get 'sync 'helm-c-yasnippet)

; insert-fileの代わりにhelmでyasnippet
(global-set-key (kbd "C-x i") 'helm-yas-complete)
