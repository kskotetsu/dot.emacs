; -*- coding: utf-8 -*-

;; for windows
(eval-after-load "jedi"
    '(setq jedi:server-command (list "/Python27/python" jedi:server-script)))

