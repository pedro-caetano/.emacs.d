(tool-bar-mode -1)
(blink-cursor-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default indent-tabs-mode nil)

(setq inhibit-startup-screen t
      initial-scratch-message ";; ready\n\n"
      package-enable-at-startup nil
      package-user-dir "~/.emacs.d/elpa/")

;; stop creating ~ backup files
(setq make-backup-files nil) 

;; font
(set-frame-font "DejaVu Sans Mono-14" nil t)

;;#############################
(require 'package)

;;-----------------------------
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)
;;-----------------------------

(package-initialize)
(eval-when-compile
    (require 'use-package))
(require 'diminish)

;;#############################

;; theme
(use-package darkokai-theme
  :ensure t
  :config (load-theme 'darkokai t))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;; iedit
(add-to-list 'load-path "~/.emacs.d/elpa/iedit-20180207.219")
(require 'iedit)

;; lsp-ui
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; company
(require 'company)
(global-company-mode) 

;; company-quickhelp [pop-up]
(company-quickhelp-mode 1)

;; company-lsp
(require 'company-lsp)
(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)


;; cquery
(require 'cquery)
(setq cquery-executable "~/dev/cquery/build/cquery")
(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :completion (:detailedLabel t)))


;;(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack"))
;;(setq cquery-extra-init-params '(:extraClangArguments ("--driver-mode=cl"))


;; auto-complete
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(setq ac-quick-help-delay 0.4)
;;(define-key ac-complete-mode-map "\t" 'ac-complete)
;;(define-key ac-complete-mode-map [return] nil)
;;(define-key ac-complete-mode-map "\r" nil)
;;(define-key ac-mode-map [C-return] 'auto-complete)
;;(setq ac-candidate-limit 100) ;; do not stall with too many results

;; bind-key
(require 'bind-key)
(bind-keys*
    ;; file operations
    ("C-o" . find-file)         ;; Open file
    ("C-s" . save-buffer)       ;; Save file
    ("C-S-s" . write-file)      ;; Save as
    ("M-Q" . kill-this-buffer)  ;; close file
    ;; buffer content operations
    ("C-a" . mark-whole-buffer) ;; Select all
    ("C-f" . search-forward)    ;; find in file
    ("C-z" . undo-tree-undo)    ;; undo
    ("C-S-z" . undo-tree-redo)  ;; redo
    ("C-c" . kill-ring-save)    ;; Copy
    ("C-x" . kill-region)       ;; Cut
    ("C-v" . yank)              ;; Paste
    ;; Pane/buffer switching
    ("M-1" . other-window)      ;; toggle pane
    ("M-2" . previous-buffer)   ;; previous file in pane
    ("M-3" . next-buffer)       ;; next file in pane
    ("<M-down>" . split-window-vertically)
    ("<M-right>" . split-window-horizontally)
    ("M-q" . delete-window)     ;; close window
    ;; font size
    ("C-+" . text-scale-increase)
    ("C--" . text-scale-decrease)
    ;; launch sub-process
    ("M-0" . term) ;; terminal
    ("M-9" . eww)) ;; browser





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(package-selected-packages
   (quote
    (lsp-ui use-package undo-tree iedit diminish darkokai-theme cquery)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 136 :width normal)))))
