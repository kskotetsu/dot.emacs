; Cgシェーダー

(el-get 'sync 'cg-mode)

(require 'cg-mode)
(setq auto-mode-alist (append (list
							   '("\\.cgfx"		.		cg-mode)
							   '("\\.hlsl"		.		cg-mode)
							   '("\\.cg"		.		cg-mode)
							   '("\\.gxsl"		.		cg-mode)
							   '("\\.gxsh"		.		cg-mode)
							   '("\\.vsh"		.		cg-mode)
							   '("\\.psh"		.		cg-mode)
							   )
							  auto-mode-alist))
