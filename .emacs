(setq mac-command-modifier 'meta)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell 
	 (replace-regexp-in-string "[[:space:]\n]*$" "" 
				   (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)

;; Rinari
(add-to-list 'load-path "~/elisp/rinari")
(require 'rinari)

;;; nxml (HTML ERB template support)
(load "~/elisp/nxhtml/autostart.el")

(setq
 nxhtml-global-minor-mode t
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 indent-region-mode t
 rng-nxml-auto-validate-flag nil
 nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

;; MuMaMo-Mode for rhtml files
(add-to-list 'load-path "~/elisp/nxhtml/util")
(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;;; rhtml-mode
(add-to-list 'load-path "~/elisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

;;; YASnippet
(add-to-list 'load-path
	     "~/elisp/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/elisp/yasnippet-0.6.1c/snippets")

(add-to-list 'load-path "~/.emacs.d/utils/")
(require 'rvm)
(rvm-use-default) ;; use rvm’s default ruby for the current Emacs session

(setq rinari-tags-file-name "TAGS")