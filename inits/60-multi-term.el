;; multi-term
(el-get 'sync 'multi-term)
(setq locale-coding-system 'utf-8)
(setq multi-term-program "/usr/local/bin/zsh")
;; term に奪われたくないキー
(add-to-list 'term-unbind-key-list '"C-a")

;; my-keybinds for keybinds -e
(defun term-send-forward-char ()
  (interactive)
  (term-send-raw-string "\C-f"))

(defun term-send-backward-char ()
  (interactive)
  (term-send-raw-string "\C-b"))

(defun term-send-previous-line ()
  (interactive)
  (term-send-raw-string "\C-p"))

(defun term-send-next-line ()
  (interactive)
  (term-send-raw-string "\C-n"))

(add-hook 'term-mode-hook
          '(lambda ()
             (let* ((key-and-func
                     `(("\C-p"           term-send-previous-line)
                       ("\C-n"           term-send-next-line)
                       ("\C-b"           term-send-backward-char)
                       ("\C-f"           term-send-forward-char)
                       (,(kbd "C-h")     term-send-backspace)
                       (,(kbd "C-y")     term-paste)
                       (,(kbd "ESC ESC") term-send-raw)
                       (,(kbd "C-S-p")   multi-term-prev)
                       (,(kbd "C-S-n")   multi-term-next)
                       ;; 利用する場合は
                       ;; helm-shell-historyの記事を参照してください
                       ;; ("\C-r"           helm-shell-history)
                       )))
               (loop for (keybind function) in key-and-func do
                     (define-key term-raw-map keybind function)))))

;; (add-hook 'term-mode-hook
;;          '(lambda ()
;;             ;; C-h を term 内文字削除にする
;;             (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
;;             ;; C-y を term 内ペーストにする
;;             (define-key term-raw-map (kbd "C-y") 'term-paste)
;;             ))

