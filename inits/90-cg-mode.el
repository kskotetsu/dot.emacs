; Cgシェーダー

(el-get 'sync 'cg-mode)

(require 'cg-mode)
(setq auto-mode-alist (append (list
							   '("\\.cgfx"		.		cg-mode)
							   '("\\.hlsl"		.		cg-mode)
							   '("\\.cg"		.		cg-mode)
							   )
							  auto-mode-alist))
