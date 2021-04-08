; -*- coding: utf-8 -*-

(eval-after-load "gtags-mode"
  '(progn
	 (setq gtags-path-style 'relative)
	 (setq gtags-auto-update t)	;ファイルセーブ時にタグファイルを更新する
	 (setq gtags-ignore-case t)	;大文字小文字 t:区別しない、nil:区別する
	 ))

(global-set-key (kbd "C-c t") 'gtags-find-tag)
(global-set-key (kbd "M-t") 'gtags-find-tag)
(global-set-key (kbd "C-t") 'gtags-pop-stack)

(global-set-key (kbd "M-t") 'helm-gtags-find-tag-from-here)
(global-set-key (kbd "C-t") 'helm-gtags-previous-history)

