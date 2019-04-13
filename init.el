(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/") t)
(add-to-list 'package-archives
             '("melpa" . "http://elpa.emacs-china.org/melpa/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.emacs-china.org/gnu/"))

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)



;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-clang-executable "/usr/bin/clang")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (flycheck-irony company-irony irony flycheck company-lsp lsp-ui cquery zygospore helm-gtags helm yasnippet ws-butler volatile-highlights-mode use-package undo-tree iedit dtrt-indent counsel-projectile clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lsp-mode
  :commands lsp
  :init
  (setq ...))
(setq lsp-clients-clangd-executable "/usr/bin/clang")

(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
(add-hook 'c++-mode-hook #'lsp)

(setq cquery-executable "/home/sgb/cquery/release/bin/cquery")
;; ;; Arch Linux aur/cquery-git aur/cquery
;; (setq cquery-executable "/usr/bin/cquery")

;; ;; Log file
;; (setq cquery-extra-args '("--log-file=/tmp/cq.log"))
;; ;; Cache directory, both relative and absolute paths are supported
;; (setq cquery-cache-dir ".cquery_cached_index")
;; ;; Initialization options
;; (setq cquery-extra-init-params '(:cacheFormat "msgpack"))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook #'irony-eldoc)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
