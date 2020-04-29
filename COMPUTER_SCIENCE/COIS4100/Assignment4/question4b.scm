#! /usr/bin/env racket

#lang scheme


( define filtera
	(lambda(p lis)
		(cond
			((empty? lis)null)
			((p(car lis))
				(cons (first lis) (filtera p (cdr lis))))
			(else (filtera p (rest lis))))))

(display(filtera (lambda(x)(< x 5)) (list 3 9 5 8 2 4 7)))