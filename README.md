# docopt.objc

Beginnings of an Objective-C (Foundation) implementation of the [docopt](http://docopt.org/) language, under a MIT license.

Written (so far) by [Ole Begemann](http://oleb.net), April 2013.

## Status

This project began with the intention to implement [docopt](http://docopt.org/) in Objective-C. Its current status (as of May 2013) is fundamentally incomplete. In fact, this project does not implement any docopt feature so far.

All it does is provide a starting point by parsing the official docopt testing fixtures at [testcases.docopt](https://github.com/docopt/docopt/blob/master/testcases.docopt) and executing these test cases against the largely empty `Docopt` class.

Currently (as of May 7th, 2013), all tests that do not expect a result of `"user-error"` fail because the `Docopt` class has no working functionality.

## Contributors Welcome

Your contributions to this project are highly welcome. These are the steps you should do:

1. Open `docopt.xcodeproj` in Xcode.
2. Run the tests by pressing `Cmd+U`.
3. Read the failing test cases and fix them one by one by adding functionality to the `-[Docopt parse]` method.
4. Refactor your implementation into nice code.

