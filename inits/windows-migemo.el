; -*- coding: utf-8 -*-

(require 'migemo)

(setq migemo-command "~/.emacs.d/cmigemo-default-win64/cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-dictionary (expand-file-name "~/.emacs.d/cmigemo-default-win64/dict/utf-8/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
(setq migemo-coding-system 'utf-8-unix)

(migemo-init)

;; migemo + swiper（日本語をローマ字検索できるようになる(require 'avy-migemo)
(avy-migemo-mode 1)
(require 'avy-migemo-e.g.swiper)

										;      '((t . ivy--regex-plus)))			;
;(global-set-key (kbd "M-SPACE") 'avy-migemo-mode)
