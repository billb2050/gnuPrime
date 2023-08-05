## gnuPrime

This gnuCOBOL program (tested with gnuCOBOL V3) is a port of the COBOL program PRIMCOB01 that is found in MVS 3.8j and is included in the TK4- package

PRIMCOB01 is an implementation of *Sieve of Eratosthenes* algorithm. Which is described by Wikipedia as...is an ancient algorithm for finding all prime numbers up to any given limit.

The original PRIMCOB01 has a upper limit of 32767 primes. gnuPrime does not have that limitation and has been modified to allow it to find primes up to one million.

Install: cobc -x gnuPrime.cob

