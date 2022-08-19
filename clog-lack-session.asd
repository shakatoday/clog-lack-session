(defsystem "clog-lack-session"
  :version "0.1.0"
  :author "Shaka Chen"
  :license "BSD"
  :depends-on ("clog")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "clog-lack-session/tests"))))

(defsystem "clog-lack-session/tests"
  :author "Shaka Chen"
  :license "BSD"
  :depends-on ("clog-lack-session"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for clog-lack-session"
  :perform (test-op (op c) (symbol-call :rove :run c)))
