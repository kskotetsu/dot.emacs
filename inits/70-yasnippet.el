;(el-get 'sync 'yasnippet)

(add-to-list 'yas-snippet-dirs
      "~/.emacs.d/snippets")

(custom-set-variables '(yas-trigger-key "TAB"))
;(yas/load-directory "~/.emacs.d/snippets/ruby-mode")
(yas-global-mode)


;(el-get 'sync 'helm-c-yasnippet)

; insert-fileの代わりにhelmでyasnippet
(global-set-key (kbd "C-x i") 'helm-yas-complete)
