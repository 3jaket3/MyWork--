#! /usr/bin/env racket

#lang scheme

(define less
 (lambda (L x)
 	(cond ((null? L) '())
 		((< (car L) x)(cons (car L) (less (cdr L) x)))
 		(else (less (cdr L) x)))))

(define great
	(lambda (L x)
		(cond ((null? L) '())
			((> (car L) x) (cons (car L) (great ( cdr L) x)))
		(else (great (cdr L) x)))))

(define append
	(lambda (L M)
		(if (null? L)
			M
			(cons (car L) (append (cdr L) M )))))

(define quicksort
	( lambda (L)
		(if (null? L)
			'()
			(append
				(append
					(quicksort (less L (car L)))
					(list (car L)))
				(quicksort ( great L (car L)))))))

(time
   (quicksort (list 4 50 30 234 324 43 490 33 30 84 39 10 5 1)) )
