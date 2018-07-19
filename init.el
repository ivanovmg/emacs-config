;; Start emacs server
(server-start)

;; Load custom packages
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my-lisp/"))

;; ----------------------------------------------------------------------------
;; MELPA
;; ----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)


;; ----------------------------------------------------------------------------
;; BASIC CUSTOMIZATION
;; ----------------------------------------------------------------------------
(setq inhibit-startup-message t) ;; hide the startup message
(set-language-environment 'UTF-8) ;; use unicode

;; enable Russian language. Shift via  Ctrl - \
(set-language-environment 'Russian)
(prefer-coding-system 'utf-8-dos)

;;my favorite scrolling
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position 't)
(setq scroll-margin 5)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "EMACS: %b")

;; ----------------------------------------------------------------------------
;; LIST OF BUFFERS
;; ----------------------------------------------------------------------------
;; Use ibuffer instead of list buffers
(global-set-key (kbd "C-x C-b") 'ibuffer) 
(defvar ibuffer-saved-filter-groups
  '(("home"
     ("emacs-config" (or (filename . ".emacs.d")
                         (filename . ".emacs")
                         (filename . "init.el")))
     ("dired" (mode . dired-mode))
     ("Org" (or (mode . org-mode)
                (filename . "OrgMode")))
     ("TeX" (or (mode . LaTeX-mode)
                  (filename . "\\.tex\\'")))
     ("Python" (or (mode . python-mode)
                  (filename . "\\.py\\'")))
     ("Help" (or (name . "\*Help\*")
                 (name . "\*Apropos\*")
                 (name . "\*info\*"))))))


;; switch between buffers and open files effectively
(ido-mode)

;; Useful autocomplete mode in message buffer
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "\e\ex") 'execute-extended-command)


;; ----------------------------------------------------------------------------
;; SAVING PREVIOUS FILES
;; ----------------------------------------------------------------------------
(desktop-save-mode 1)
(setq desktop-auto-save-timeout 60) ;; save session every 60 seconds

;; ----------------------------------------------------------------------------
;; CUSOMIZE MODELINE
;; ----------------------------------------------------------------------------
(require 'powerline)
(powerline-vim-theme)

;; modify which modes are highlighted in modeline and how
(require 'delight)
(delight 'abbrev-mode " Abv" 'abbrev)
(delight 'python-docstring-mode nil 'python-docstring)
(delight 'eldoc-mode nil 'eldoc)
(delight 'anaconda-mode nil 'anaconda-mode)
(delight 'company-mode nil 'company)
(delight 'python-cell-mode " ##" 'python-cell)
(delight 'yas-minor-mode " ¥" 'yasnippet)
(delight 'volatile-highlights-mode nil 'volatile-highlights)
(setq column-number-mode t)  ;; show column number as well


;; ----------------------------------------------------------------------------
;; THEMING
;; ----------------------------------------------------------------------------
;;(load-theme 'material t)
;;(load-theme 'misterioso t)
;;(load-theme 'flatland t)
(load-theme 'zenburn t)  ;; the best so far, for LaTeX and Python


;; ----------------------------------------------------------------------------
;; LINE NUMBERS AND COLUMNS
;; ----------------------------------------------------------------------------
;; line numbers
(global-linum-mode t) ;; enable line numbers globally

;; highlight current line
(global-hl-line-mode 1)
(set-face-background hl-line-face "dark slate gray")
(set-face-foreground 'highlight nil)
(set-face-underline hl-line-face 'nil)

;; color for the region selected
(set-face-attribute 'region nil :background "DeepSkyBlue4" :foreground nil)

(volatile-highlights-mode 1)


;; ----------------------------------------------------------------------------
;; AUTOCOMPLETE
;; ----------------------------------------------------------------------------
;; Autocomplete in buffer
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; Working with windows
(winner-mode t)
(windmove-default-keybindings)


;; ----------------------------------------------------------------------------
;; FONT
;; ----------------------------------------------------------------------------
(set-face-font 'default "Terminus-12")
;; (set-face-font 'default "Consolas-12")  ;; alternative font
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)


;; ----------------------------------------------------------------------------
;; FILL COLUMN
;; ----------------------------------------------------------------------------
(setq-default fill-column 80)
(require 'fill-column-indicator)
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Column enforce mode
(global-column-enforce-mode t)
;; allow long comments
(setq column-enforce-comments nil)


;; ----------------------------------------------------------------------------
;; IMENU
;; ----------------------------------------------------------------------------
(require 'imenu)
(setq imenu-auto-rescan      t) ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil) ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f6>") 'imenu) ;; вызов Imenu на F6

;; ----------------------------------------------------------------------------
;; Disable GUI components
;; ----------------------------------------------------------------------------
(tooltip-mode      t)
(menu-bar-mode     t)
(tool-bar-mode     -1)
;(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore) ;; no beeping
(w32-send-sys-command 61488)      ;; start in full screen (works imperfectly)

;; ----------------------------------------------------------------------------
;; PARENTHESES
;; ----------------------------------------------------------------------------
;; Show-paren-mode settings
; By default, there’s a small delay before showing a matching parenthesis. It
; can be deactivated
(setq show-paren-delay 0)
(show-paren-mode t) ;; highlight brackets


;; Undo tree
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-visualize)

;; ----------------------------------------------------------------------------
;; Python
;; ----------------------------------------------------------------------------
(require 'python)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args ""
      ;; python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      ;; python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      ;; python-shell-completion-setup-code
      ;; "from IPython.core.completerlib import module_completion"
      ;; python-shell-completion-module-string-code
      ;; "';'.join(module_completion('''%s'''))\n"
      ;; python-shell-completion-string-code
      ;; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
)

(defun python-send-line ()
  (interactive)
  (save-excursion 
    (back-to-indentation)
    (python-shell-send-string (concat (buffer-substring-no-properties (point)
                                                         (line-end-position)) 
                                      "\n"))))

(defun set-python-keybindings ()
  (local-set-key (kbd "M-n") 'python-nav-forward-block)
  (local-set-key (kbd "M-p") 'python-nav-backward-block)
  (local-set-key "\C-cp" 'python-nav-backward-up-list)
;  (local-set-key "\C-c\C-n" 'python-shell-send-line-and-step)  ;; already enabled by default
  (local-set-key (kbd "<f9>") 'python-shell-send-line)  ;; like in Spyder
  (local-set-key "\C-c\C-a" 'python-send-buffer-with-my-args)
)

(add-hook 'python-mode-hook 'set-python-keybindings)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'fci-mode)

;; enable code cells via python-x
(python-x-setup)
(setq python-section-delimiter "#%%")


;; ----------------------------------------------------------------------------
;; ORG MODE
;; ----------------------------------------------------------------------------
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "W:/project_management/NTC.org"
			     ))

;; ----------------------------------------------------------------------------
;; MAGIT
;; ----------------------------------------------------------------------------
(global-set-key (kbd "C-x g") 'magit-status)


;; ----------------------------------------------------------------------------
;; LaTeX
;; ----------------------------------------------------------------------------
;; Setup interaction with PDF viewer SumatraPDF
(require 'sumatra-forward)
(setq TeX-source-correlate-method (quote synctex))
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-view-program-list (quote 
   (("SumatraPDF" "\"C:/Program Files/SumatraPDF/SumatraPDF.exe\"
   -reuse-instance %o"))))
(setq TeX-view-program-selection '((output-pdf "SumatraPDF")))


;; AuCTeX setup
(require 'auto-complete-auctex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-auto-full-regexp-list t)
(setq-default TeX-master nil)
(setq LaTeX-item-indent 0)
;; (setq TeX-PDF-mode t)  ;; this seems to be unnecessary
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(setq TeX-auto-untabify t)  ;; convert tabs to spaces

;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)


;; setup key bindings for latex mode
(defun set-latex-keybindings ()
  (local-set-key (kbd "\e\en") 'TeX-next-error)
  (local-set-key (kbd "\e\ep") 'TeX-previous-error)
  (local-set-key "\C-x\C-j" 'sumatra-jump-to-line)
)
(add-hook 'LaTeX-mode-hook 'set-latex-keybindings)

(add-hook 'LaTeX-mode-hook 'fci-mode)  ;; enable fill-column indicator


;; ----------------------------------------------------------------------------
;; KEY BINDINGS
;; ----------------------------------------------------------------------------

;; Windows operations
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "<f8>") 'other-frame)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECENT Files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\C-r" 'recentf-open-files)

;; If Emacs exits abruptly for some reason the recent file list will be lost -
;; therefore you may wish to call `recentf-save-list` periodically, e.g. every 5
;; minutes:
(run-at-time nil (* 5 60) 'recentf-save-list)

;; ----------------------------------------------------------------------------
;; 
;; ----------------------------------------------------------------------------



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow zenburn-theme yasnippet-snippets volatile-highlights undo-tree tangotango-theme tabbar switch-window sr-speedbar speed-type solarized-theme smex pyvenv python-x python-docstring python-cell powerline page-break-lines monokai-theme minimap material-theme magit leuven-theme latex-preview-pane jedi highlight-indentation flycheck flatland-theme fill-column-indicator ein e2wm dracula-theme doom-themes delight company-auctex column-enforce-mode color-theme better-defaults auto-complete-auctex anaconda-mode alect-themes academic-phrases))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
