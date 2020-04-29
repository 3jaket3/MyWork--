#! /usr/bin/env racket

#lang scheme

(define rotation (lambda (lis)
	(define helper(lambda(x y z)
		(if (null? y) z
			(helper (append x (list(car y)))(cdr y) (cons (append y x)z)))))
(if (empty? lis) lis
	(helper null lis null) )))

(display(rotation(list 1 2 3 4 5)))