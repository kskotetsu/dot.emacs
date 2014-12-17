; -*- coding: utf-8 -*-

(require 'bm)
(defun bm-find-files-in-repository ()
  (interactive)
  (cl-loop for (key . _) in bm-repository
           when (file-exists-p key)
           do (find-file-noselect key)))
(defun bm-repository-load-and-open ()
  (bm-repository-load)
  (bm-find-files-in-repository))

(setq bm-repository-file "~/.emacs.d/bm-repository")
(setq-default bm-buffer-persistence t)
;(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(add-hook 'after-init-hook 'bm-repository-load-and-open)
(defun bm-buffer-restore-safe ()
  (ignore-errors (bm-buffer-restore)))
(add-hook 'find-file-hooks 'bm-buffer-restore-safe)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(defun bm-save-to-repository ()
  (interactive)
  (unless noninteractive
    (bm-buffer-save-all)
    (bm-repository-save)))

(add-hook 'kill-emacs-hook 'bm-save-to-repository)
(run-with-idle-timer 600 600 'bm-save-to-repository)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'before-save-hook 'bm-buffer-save)


(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))

(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

