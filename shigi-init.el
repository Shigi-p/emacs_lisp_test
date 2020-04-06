;; 実践emacsを写経して設定をいじってみるの巻
;; コピペもいっぱい混ざっているのでもうわけわかんない

;; PATH関連
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'exec-path "/usr/local/share")
(add-to-list 'exec-path "/bin")

;; 改行と同時にインデント
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; C-hをバックスペースに変更
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; C-?にヘルプを割り当ててみる
(define-key key-translation-map (kbd "C-x ?") 'help-command)

;; C-tでウィンドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; カラム番号も表示するようにしてあげる
(global-linum-mode t)

;; テーマも指定してみる
(load-theme 'misterioso)

;; 空白も表示するようにしてみる
(global-whitespace-mode 1)

;; 編集している行のハイライトを入れてみる
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺に
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;; 背景がlightならば背景色を青に
    (((class color) (background lighr))
     (:background "LightSkyBlue" t))
    (t (:bold t)))
  "hl-line's my face")
;;(setq hl-line-face 'my-li-line-face')
(global-hl-line-mode t)

;; 対応する括弧を表示する
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "garkgreen")

;; Rubyを触るにあたり便利そうなものを公式からひっぱってきた
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; markdownのプレビュー用の設定
(autoload 'markdown-preview-mode "markdown-preview-mode.el" t)

;; インデントを2にしたい
(setq sh-basic-offset 2)

;; splash screenを無効にする(起動時のよくわからんウィンドウ)
(setq inhibit-splash-screen t)

;; ディスプレイサイズの確認
(display-monitor-attributes-list)
;; (((name . "eDP-1") (geometry 0 0 1920 1080) (workarea 67 27 1853 1053) (mm-size 293 165) (frames #<frame emacs@shigi-UX310UAK 0x12fac30>) (source . "Gdk")))

;; デフォルトのウィンドウサイズの調整
(setq default-frame-alist
      '(
	(width . (text-pixels . 1920))
	(height . (text-pixels . 1080))
	))

;; 自動保存系のファイルを設定
(setq make-backup-files t)
(setq auto-save-file-name-transforms   '((".*" "~/tmp/" t)))
 ;; 保存の間隔
(setq auto-save-timeout 10)     ;; 秒   (デフォルト : 30)
(setq auto-save-interval 100)   ;; 打鍵 (デフォルト : 300)

;; ビープ音の代わりに画面フラッシュ
(setq ring-bell-function 'ignore)

;; スクロールを1行ずつ
(setq scroll-conservatively 1)
;; スクロールのマージンを5行くらいに
(setq scroll-margin 5)

;; フォントをM+に
(setq default-frame-alist
      (append (list
	       '(font . "M+ 2m light"))
              default-frame-alist))
;; 以下パッケージ関連
;; パッケージ読み込み
(require 'package)

;; HTTPS 系のリポジトリ
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; HTTP 系のリポジトリ
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://elpa.gnu.org/") t)

;; marmalade　は HTTP アクセスすると証明書エラーでフリーズするので注意
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; gitっぽいパッケージツールをぶちこんだ
(require 'magit)

;; 最強と謳われる補完機能のパッケージをぶちこんだ
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")

;; web関連のパッケージをぶちこんだ
(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.html//'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css//'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js//'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx//'" . web-mode))
  )

;; vueのなにかをぶちこんだ
(require 'vue-html-mode)

;; vueのなにかすごいやつをぶちこんだ
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face nil)

;; reactのやつをぶちこんだ
(require 'rjsx-mode)

;; なんだこれ わすれた
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode+ uuid uuidgen markdown-preview-mode websocket vue-mode web-mode vue-html-mode ssass-mode rjsx-mode relax popup-complete magit edit-indirect auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-initialize)
