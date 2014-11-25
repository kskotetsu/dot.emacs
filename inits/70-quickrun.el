(require 'quickrun)

(push '("*quickrun*") popwin:special-display-config)

(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "s-<f5>") 'quickrun-with-arg)


;; ;; pythonの実行時にvirtualenvから実行ファイルを得る
;; ;; http://d.hatena.ne.jp/podhmo/20120325/1332647449

;; ;;; utility
;; (defun search-target--all-candidates (head words)
;;   (loop for word in words
;; 		with acc = head
;; 		unless (string-equal "" word)
;; 		do (setq acc (concat acc "/" word))
;; 		collect acc into result
;; 		finally return (nreverse (cons head result))))

;; (defun search-target--find-all (target candidates)
;;   (remove-if-not (lambda (path)
;; 				   (file-exists-p (concat path "/" target)))
;; 				 candidates))

;; (defun search-target--find-one (target candidates)
;;   (find target candidates
;; 		:test (lambda (target path)
;; 				(file-exists-p (concat path "/" target)))))

;; (defun search-target-exist-in-path (path target &optional find-all-p)
;;   "search a target file from all candidate from current directory path.
;; e.g.
;; path: /foo/bar/baz, target: Makefile,
;; search matched file from (/foo/bar/baz/Makefile /foo/bar/Makefile /foo/Makefile /Makefile)
;; "
;;   (destructuring-bind (head . words) (split-string path "/")
;; 	(let ((candidates (search-target--all-candidates head words)))
;; 	  (cond (find-all-p (search-target--find-all target candidates))
;; 			(t (search-target--find-one target candidates))))))

;; (defun target-in-path (target &optional find-all-p)
;;   "check target fron default-directory "
;;   (and default-directory
;; 	   (search-target-is-exist-in-path
;; 		(file-truename default-directory)
;; 		target find-all-p)))

;; (defun* find-command-from-cwd (cmd &optional (prefix "bin/"))
;;   (let ((root (target-in-path (concat prefix cmd))))
;; 	(if root (concat root "/" prefix cmd) cmd)))

;; ;; functions
;; (defun quickrun-python/virtualenv ()
;;   (find-command-from-cwd "python"))

;; (defun quickrun-pyflakes/virtualenv ()
;;   (format "%s %%s" (find-command-from-cwd "pyflakes")))

;; ;;; setup
;; (defun quickrun/virtualenv-setup ()
;;   (setq quickrun/language-alist
;; 		(remove* "python" quickrun/language-alist :key 'car :test 'equal))
  
;;   (push '("python" . ((:command . quickrun-python/virtualenv) (:compile-only . quickrun-pyflakes/virtualenv)
;; 					  (:description . "Run Python script")))
;; 		quickrun/language-alist))


;; (provide 'quickrun-with-virtualenv)


;; ;;; setup
;; (quickrun/virtualenv-setup)

