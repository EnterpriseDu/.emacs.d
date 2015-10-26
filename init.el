;;===============================General Settings=================================
(setq user-mail-address "du@mail.bnu.edu.cn"
      user-full-name "Du Zhifang")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(setq initial-frame-alist '((width . 120) (height . 40)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/MySchedule/Temporary.org" "~/MySchedule/Others.org" "~/MySchedule/Political.org" "~/MySchedule/English.org" "~/MySchedule/Math.org")))
 '(py-shell-switch-buffers-on-execute nil)
 '(text-mode-hook (quote (text-mode-hook-identify))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#93a8c6"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#6495ed"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#1e90ff"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#4169e1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#7b68ee"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#9932cc"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#dc143c"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#ff4500"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#ff8c00")))))


;; set the font
(set-default-font "Monaco-10")
;(dolist (charset '(kana han symbol cjk-misc bopomofo))
;  (set-fontset-font (frame-parameter nil 'font)
;                    charset (font-spec :family "AR PL UMing CN"
;                                       :size 12)))


;; doesn't seem to work
(setq scroll-step 5 scroll-margin 3 scroll-conservatively 10000)

;; M-x goto-line
(global-set-key (kbd "C-j") 'goto-line)

;; no startup figure
(setq inhibit-startup-message t)

;; default directory
(setq default-directory "/home/duzf/")

;; if no operation, the cursor will blink
;; 10 times then stay still
(blink-cursor-mode nil)

;; show the column number and the line number
(column-number-mode t)
(global-linum-mode t)

;;highlight the current line
;(global-hl-line-mode t) ; too flashing......

;; show the matching pairs of parentheses
;(show-paren-mode t) ; too flashing......
 
;; no tool bar
(tool-bar-mode 0)

;; no scroll bar
(scroll-bar-mode 0)

;; emacs debuger says no function org-startup-truncated
;(org-startup-truncated nil)

;; emacs debuger says no function cursor-color
;(cursor-color "#839496")


;; redo-undo
;; emacs debuger says no file undo-tree
;(require 'undo-tree)
;(global-undo-tree-mode 1)
;(defalias 'redo 'undo-tree-redo)
;(global-set-key (kbd "C-z") 'undo)
;(global-set-key (kbd "C-S-z") 'redo)


;; maximize the emacs window
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;; maximize the emacs window when start
;(my-maximized) ; really works!

;;==================================Theme====================================
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
    (require 'color-theme)

(load "~/.emacs.d/plugins/color-theme/themes/color-theme-molokai.el")
(color-theme-molokai)



;;================================Programming languages============================

(add-to-list 'load-path
	     "~/.emacs.d/plugins/")

;;-----------------General------------------
;;auto complete
;(require 'auto-complete-config)
;(ac-config-default)
;;complete file path
;(setq-default ac-sources (append ac-sources '(ac-source-filename)))

;;rainbow delimiter mode
(add-to-list 'load-path
	     "~/.emacs.d/plugins/elpa")
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;(global-rainbow-delimiters-mode)

;;--------------------python--------------------
(add-to-list 'load-path
	     "~/.emacs.d/plugins/python")

(require 'python-mode) 
(require 'ipython) 
(setq py-python-command-args '("--pylab" "--colors" "LightBG"))

;; indentation mode
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#bfafb2")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

(add-hook 'python-mode-hook 'highlight-indentation-mode)
(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key "\C-ci" 'aj-toggle-fold)


;;----------------Shell--------------
;;essh                                                                   
(require 'essh)                                                    
(defun essh-sh-hook ()                                             
  (define-key sh-mode-map "\C-c\C-r" 'pipe-region-to-shell)        
  (define-key sh-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)        
  (define-key sh-mode-map "\C-c\C-j" 'pipe-line-to-shell)          
  (define-key sh-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step) 
  (define-key sh-mode-map "\C-c\C-f" 'pipe-function-to-shell)      
  (define-key sh-mode-map "\C-c\C-d" 'shell-cd-current-directory)) 
(add-hook 'sh-mode-hook 'essh-sh-hook)  





;;==================================AucTex===============================
;(add-to-list 'load-path "~/.emacs.d/plugins/auctex/site-lisp/site-start.d")
(load "auctex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(load "preview-latex.el" nil t t)


(add-hook 'LaTeX-mode-hook (lambda()
            (define-key LaTeX-mode-map "C-m" 'reindent-then-newline-and-indent)
            (setq TeX-auto-untabify t     ; remove all tabs before saving 
               ;   TeX-engine 'xetex       ; use xelatex default 
                  TeX-show-compilation t) ; display compilation windows 
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain 
            (setq TeX-save-query nil) 
            (imenu-add-menubar-index) 
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
))

(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)




;;=========================Yasnippet==========================
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")



;;=========================CEDET==============================
;;(add-to-list 'load-path
;;	     "~/.emacs.d/plugins/cedet-1.1/common")

;;(require 'cedet)
;;(require 'semantic-ia)
;; ;; 
;;(global-ede-mode t)
;; ;; 
;;(semantic-load-enable-minimum-features)
;;(semantic-load-enable-code-helpers)
;; ;; (semantic-load-enable-gaudy-code-helpers)
;; ;; (semantic-load-enable-excessive-code-helpers)

;(defconst cedet-user-include-dirs
;  (list ".." "../include" "../inc" "../common" "../public"
;          "./lib"    "./include"   "./inc"  "./common" "./public"))

;(require 'semantic-c nil 'noerror)
;(let ((include-dirs cedet-user-include-dirs))
;  (mapc (lambda (dir)
;          (semantic-add-system-include dir 'c++-mode)
;          (semantic-add-system-include dir 'c-mode))
;        include-dirs))

;(global-set-key [f12] 'semantic-ia-fast-jump)

(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let- ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;; (define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)
;(global-set-key [M-Shift-f12] 'semantic-analyze-proto-impl-toggle)


;(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)


;;(require 'semantic-tag-folding nil 'noerror)
;;(global-semantic-tag-folding-mode 1)

;(add-hook 'c-mode-hook 'hs-minor-mode)
;(add-hook 'c++-mode-hook 'hs-minor-mode) 

 



;;=========================================================
;; (require 'cc-mode)
;; (c-set-offset 'inline-open 0)
;; (c-set-offset 'friend '-)
;; (c-set-offset 'substatement-open 0)

;; (defun my-c-mode-common-hook()
;;   (setq tab-width 4 indent-tabs-mode nil)
;;   ;;; hungry-delete and auto-newline
;;   (c-toggle-auto-hungry-state 1)
;;   ;;按键定义
;;   (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
;;   (define-key c-mode-base-map [(return)] 'newline-and-indent)
;;   (define-key c-mode-base-map [(f7)] 'compile)
;;   (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
;;   ;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
;;   (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
;;   (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu))


(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)


;;======================Git==================================
(add-to-list 'load-path "~/.emacs.d/git-emacs/") (require 'git-emacs)

;;======================Org==================================
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)



;;babel to evaluate the code
 (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (R . t)
     (dot . t)
     (ruby . t)
     (python . t) 
     (sh . t)
     (perl . t)
     (latex . t)
     (clojure . t)
     (sh . t)
     )
 )

;;do not ask before evaluation
(setq org-confirm-babel-evaluate nil)

;;to use minted package
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("linenos" "true")
	("fontsize" "\\scriptsize")
        ("bgcolor" "bg")  ;; this is dependent on the color being defined
        ("stepnumber" "1")
        ("numbersep" "10pt")
        )
      )
(setq my-org-minted-config (concat "%% minted package configuration settings\n"
                                   "\\usepackage{minted}\n"
				   "\\renewcommand\\listingscaption{Source}"
                                   "\\definecolor{bg}{rgb}{0.8,0.8,0.8}\n" 
                                   "\\usemintedstyle{emacs}\n"
                                   "\\usepackage{upquote}\n"
                                   "\\AtBeginDocument{%\n"
                                   "\\def\\PYZsq{\\textquotesingle}%\n"
                                   "}\n"
                                    ))

;;#+LATEX_CMD: pdflatex/xelatex/lualatex
(defun my-org-tex-cmd ()
  "set the correct type of LaTeX process to run for the org buffer"
  (let ((case-fold-search t))
    (if (string-match  "^#\\+LATEX_CMD:\s+\\(\\w+\\)"   
                       (buffer-substring-no-properties (point-min) (point-max)))
        (downcase (match-string 1 (buffer-substring-no-properties (point-min) (point-max))))
      "xelatex"
    ))
  )

(defun set-org-latex-pdf-process (backend)
  "When exporting from .org with latex, automatically run latex,
   pdflatex, or xelatex as appropriate, using latexmk."
  (setq org-latex-pdf-process
        (list (concat "latexmk -pdflatex='" 
                      (my-org-tex-cmd)
                      " -shell-escape -interaction nonstopmode' -CF  -pdf -f  %f" ))))
(add-hook 'org-export-before-parsing-hook 'set-org-latex-pdf-process)

;; (setq org-latex-pdf-process '("xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"
;; 			      "xelatex  -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-default-packages-alist
        '(("" "fixltx2e" nil)
          ("" "longtable" nil)
          ("" "graphicx" t)
          ("" "wrapfig" nil)
          ("" "soul" t)
          ("" "marvosym" t)
          ("" "wasysym" t)
          ("" "latexsym" t)
          ("" "tabularx" nil)
          ("" "booktabs" nil)
          ("" "xcolor" nil)
          "\\tolerance=1000"
          )
        )


(defun my-auto-tex-packages (backend)
  "Automatically set packages to include for different LaTeX engines"
  (let ((my-org-export-latex-packages-alist 
         `(("pdflatex" . (("AUTO" "inputenc" t)
                          ("T1" "fontenc" t)
                          ("" "textcomp" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil) ;; It is better to put hyperref as the last package imported
			  ("" "apacite" t)
			  ("" "natbib" t)			 
                          ("capitalize,noabbrev" "cleveref"  nil)
                          ,my-org-minted-config))
           ("xelatex" . (("" "url" t)
                         ("" "fontspec" t)
                         ("" "xltxtra" t)
                         ("" "xunicode" t)
			 ("" "apacite" t)
			 ("" "natbib" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil)
                          ("capitalize,noabbrev" "cleveref"  nil)
                         ,my-org-minted-config ))
           ("lualatex" . (("" "url" t)
                       ("" "fontspec" t)
                          ("" "varioref"  nil)
			  ("" "hyperref" nil)
			  ("" "apacite" t)
			  ("" "natbib" t)
                          ("capitalize,noabbrev" "cleveref"  nil)
                       ,my-org-minted-config ))
           ))
        (which-tex (my-org-tex-cmd)))
    (if (car (assoc which-tex my-org-export-latex-packages-alist))
        (setq org-latex-packages-alist 
              (cdr (assoc which-tex my-org-export-latex-packages-alist)))
      (warn "no packages")
      )
    )
  )
(add-hook 'org-export-before-parsing-hook 'my-auto-tex-packages 'append)










;;LATEX_CLASSES
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(setq org-latex-classes
                `(("book"
                        (,@ (concat  "\\documentclass[]{book}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     ))
                        ("\\chapter{%s}" . "\\chapter*{%s}")
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

		  ("memoir"
                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{memoir}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     "\\counterwithout{section}{chapter}\n"
                                     ))
                        ("\\chapter{%s}" . "\\chapter*{%s}")
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                  ("article"
                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{article}\n"
				     "\\usepackage{tabulary}\n"
				     "\\usepackage{amsmath}\n"
				    ;; "\\usepackage{appendix}\n"
				     "\\usepackage[margin=10pt,font=small,labelfont=bf]{caption}\n"
				     "\\usepackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}\n"
				    ;; "\\usepackage{hyperref}\n"
				    ;; "\\usepackage{float}\n"
				    ;; "\\floatstyle{plaintop}\n"
				    ;; "\\restylefloat{table}\n"
                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
                                     "% -- PACKAGES \n[PACKAGES]\n"
                                     "% -- EXTRA \n[EXTRA]\n"
                                     ))
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;		  ("cn-article"
;                        (,@ (concat  "\\documentclass[11pt,oneside,a4paper,x11names]{article}\n"
;				     "\\usepackage[BoldFont=楷体,ItalicFont=楷体,BoldItalicFont=楷体,SlantedFont=楷体,BoldSlantedFont=楷体]{xeCJK}\n"
;				     "\\setCJKmainfont{楷体}\n"
;				     "\\setCJKsansfont{楷体}\n"
;				     "%use fc-list :lang=zh-cn to show all the installed Chinese fonts\n"
;				     "%楷体，幼圆，仿宋，新宋体，黑体\n"
;                                     "% -- DEFAULT PACKAGES \n[DEFAULT-PACKAGES]\n"
;                                     "% -- PACKAGES \n[PACKAGES]\n"
;                                     "% -- EXTRA \n[EXTRA]\n"
;                                     ))
;                        ("\\section{%s}" . "\\section*{%s}")
;                        ("\\subsection{%s}" . "\\subsection*{%s}")
;                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
;                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
("beamer"
	 (,@ (concat "\\documentclass[compress,presentation]{beamer}\n"
		     "\\institute{GIS}\n"
		     "\\usetheme{Ilmenau}\n"
;;		     "\\usecolortheme{lily}"
		     "\\usefonttheme{structurebold}\n"
		     "\\useoutertheme[subsection=true]{smoothbars}\n"
		     "\\useinnertheme{circles}\n"
		     "\\setbeamercovered{transparent}"
		     ))
	 ("\\section{%s}" . "\\section*{%s}")
	 ("\\subsection{%s}" . "\\subsection*{%s}")
	 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
		   ))
