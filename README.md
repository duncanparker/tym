# tym - a framework foundation

_This is currently under development - stashing code as I go._

## What is Complete

- Interfaces and base classes for basic data objects
- Database basic type mappings
- postgres connection test

## Project Prerequisites
This project is built with dub.

`apt-get install dub`

_This application has only been tested with the dmd compiler with dub._

_TODO: add link library requirements_

## Installation
clone this project and run the following in your local directory.

change struct Settings in implementation/implmenetation.d to your postgres db connection

`dub build`

`dub run`

if the above is successful hit http://127.0.0.1/build/testconnection if the response contains the text "Success" your connection to you database is successful.

## TODO

- List build full set of requirements in this README
- Improve installation intructions
- Allow/handle implicit casts from char to other types, from int to float, etc...
- Create parameterized query factory to build queries based on the objects fed into it (including creation/altering of tables, indexes0)
- Create an authentication method and tokeniser and limit access to sensitive functionality based on cookies. 
- Add documentation to classes, methods and properties.
