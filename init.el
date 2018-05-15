;;;; emacs configuration file


;;; my default preferences -------------------------------

(tool-bar-mode -1)
(blink-cursor-mode -1)
(add-to-list 'default-frame-alist 
    '(fullscreen . maximized))

(setq-default indent-tabs-mode nil)

(setq inhibit-startup-screen t
      initial-scratch-message ";; ready\n\n"
      package-enable-at-startup nil
      package-user-dir "~/.emacs.d/elpa/")

;; stop creating backup '~*.*' files
(setq make-backup-files nil) 

;; font
(set-frame-font "DejaVu Sans Mono-14" nil t)


;;; init for subsequent packages ------------------------

(require 'package)

;; add melpa address
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(eval-when-compile
    (require 'use-package))

;;; theme -----------------------------------------------

(use-package darkokai-theme
  :ensure t
  :config (load-theme 'darkokai t))

;;; non built-in packages -------------------------------

;; diminish
(require 'diminish)

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

;;(setq cquery-extra-init-params '(:extraClangArguments ("--driver-mode=cl"))

;; bind-key
(require 'bind-key)
(bind-keys*
    ;; file operations
    ("C-o" . find-file)         ; Open file
    ("C-s" . save-buffer)       ; Save file
    ("C-S-s" . write-file)      ; Save as
    ("M-Q" . kill-this-buffer)  ; close file
    ;; buffer content operations
    ("C-a" . mark-whole-buffer) ; Select all
    ("C-f" . search-forward)    ; find in file
    ("C-z" . undo-tree-undo)    ; undo
    ("C-S-z" . undo-tree-redo)  ; redo
    ("C-c" . kill-ring-save)    ; Copy
    ("C-x" . kill-region)       ; Cut
    ("C-v" . yank)              ; Paste
    ;; Pane/buffer switching
    ("M-1" . other-window)      ; toggle pane
    ("M-2" . previous-buffer)   ; previous file in pane
    ("M-3" . next-buffer)       ; next file in pane
    ("<M-down>" . split-window-vertically)
    ("<M-right>" . split-window-horizontally)
    ("M-q" . delete-window)     ; close window
    ;; font size
    ("C-+" . text-scale-increase)
    ("C--" . text-scale-decrease)
    ;; launch sub-process
    ("M-0" . term) ; terminal
    ("M-9" . eww)) ; browser