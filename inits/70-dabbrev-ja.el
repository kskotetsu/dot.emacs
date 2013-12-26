(setq el-get-sources
      '(el-get
        (:name dabbrev-ja
               :description "dabbrev-ja"
               :type http
               :url "http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el"
               :load-path (".")
               )
        (:name dabbrev-highlight
               :description "dabbrev-highlight"
               :type http
               :url "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el"
          :load-path (".")
          )))


;======================================================================
;; http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el
;======================================================================

(el-get 'sync '(dabbrev-ja))
(require 'dabbrev)
(load "dabbrev-ja")

;======================================================================
;; http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el
;======================================================================

(el-get 'sync '(dabbrev-highlight))
(require 'dabbrev-highlight)
