(defpackage clog-lack-session/tests/main
  (:use :cl
        :clog-lack-session
        :rove))
(in-package :clog-lack-session/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :clog-lack-session)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
