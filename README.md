# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version : 3.2.2

* System dependencies

* Configuration

* Database creation: Postgresql with username/postgres and password/postgres

* Secrets/environment variables: use `VISUAL="nano" bin/rails credentials:edit --environment development`
  It has username and password of database in use for postgresql

* Database initialization: 

* How to run the test suite: `rails test` 
  Use this file direct path for our service: `rails test test/services/calculator_test.rb`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Key concepts:

  Default delimiter	e.g "1,2\n3"	# Supports comma and newline
  Single custom delimiter e.g "//;\n1;2"	# Parses ; as delimiter
  Multi-character delimiter	e.g "//[***]\n1***2***3"	# Parses *** as delimiter
  Multiple delimiters e.g  "//[*][%]\n1*2%3"	# Supports both * and %
  Multiple multi-character delimiters	e.g "//[***][@@]\n1***2@@3***4"	# Supports *** and @@
  Negative numbers	e.g "1,-2"	# Raises negative numbers not allowed: -2
