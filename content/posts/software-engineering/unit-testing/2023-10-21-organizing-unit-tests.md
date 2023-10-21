+++
title = "Unit Testing: Organizing Test Directories and Files"
date = 2023-10-21
description = "Unit tests codebase can be huge in the long run, just like business logic code that it's generally hard to maintain huge code file, there's a mental blocker everytime an engineer opens a large code/test file."

[taxonomies]
tags = ["software-engineering", "best-practices", "unit-testing"]
+++


# Motivation
It's common for a function to have many positive and negative cases,
which means it demands more testing code. Testing code can grow large until it's hard to read and navigate your unit test codebase.
Organizing unit tests will help you to read and navigate through the codebase,
it also lowers the mental effort maintaining the codebase, this is true
not only for unit tests but also applies generally.

These are the common goals that you can use to organize your unit tests:
1. Visibility. Visibility means it's easy to search and navigate through the test files.
2. Readability. Readability focuses on the testing file content and structure.


# Visibility: Directory and File path structure
Some modern programming languages have conventions on organizing test directories and files, you just need to follow the conventions.
* Go has a convention to put test code in a different file under [the same source code directory](https://go.dev/doc/tutorial/add-a-test) e.g. `foo.go` will have test file `foo_test.go`
* Rust has a convention to put the tests together in the file [source code](https://doc.rust-lang.org/book/ch11-03-test-organization.html#:~:text=You'll%20put%20unit%20tests,code%20that%20they're%20testing.)

If the language has no convention, I usually mirror the test file path to the source code file path.
Suppose that you have `src/finance/tax-calculator.js`, there will be a test file with path `test/unit/finance/tax-calculator.spec.js`,
notice that the test file path has a different prefix and file extension with the source code file (`src/*` vs `test/unit/*`, `.js` vs `.spec.js`),
this is a convention that I follow because it's easier to search and keep the main codebase source directory clean.

```
▾ src/
  ▾ finance/
      tax-calculator.js
▾ test/
  ▾ finance/
      tax-calculator.spec.js
```


# Readability: Splitting large testing code file
Maintaining a large testing file is challenging, it's like maintaining a code file that has thousands of lines of code,

There are 3 test file components that can be separated quite easily:
* Target functions that are being tested.
* Testing data (fixtures).
* Common test utilities.

#### Separating unit tests per target function
It's generally a good idea to start splitting a large test file into multiple test files, 1 test file should cover only 1 target function/method.
The definition of a large test file should be similar to the definition of a large business logic module/class in your engineering team.
I personally use 2k lines of code threshold to start the splitting.

Suppose `test/unit/finance/tax-calculator.spec.js` is more than 2k lines of code and it contains 3 target functions: `calculateTaxForExpat()`, `calculateTaxForCitizen()`, and `calculateTaxForSmallBusiness()`. We would have 3 test files after splitting:

```
▾ src/
  ▾ finance/
      tax-calculator.js
▾ test/
  ▾ finance/
    ▾ tax-calculator/
        calculate-tax-for-expat.spec.js
        calculate-tax-for-citizen.spec.js
        calculate-tax-for-small-business.spec.js
```

#### Separating unit test data (fixtures)
When test input data are more than 10% of the testing code, I recommend moving
the test data into a separate fixture file. It's easier to navigate through the testing code if the testing logic is concise.

```
▾ test/
  ▾ finance/
    ▾ tax-calculator/
        calculate-tax-for-expat.spec.js
        calculate-tax-for-expat.fixture.js
        calculate-tax-for-citizen.spec.js
        calculate-tax-for-citizen.fixture.js
        calculate-tax-for-small-business.spec.js
        calculate-tax-for-small-business.fixture.js
```

#### Separating common test utilities
We can separate common test logic into a separate code module/class so it's easier to reuse it.
If the reused test common logic is only a couple of lines and rarely reused across test cases then better to keep it within the same test file,
otherwise, we can group common logic further based on where it's reused:
1. Reused common logic in many unit test cases in the same testing file. We can put it in the same directory as the test class/module:
```
▾ test/
  ▾ finance/
    ▾ tax-calculator/
        ...
        calculate-tax-for-expat.utilities.js
        ...
```

2. Reused common logic in the same target class/module will have a separate file in the class/module directory.
```
▾ test/
  ▾ finance/
    ▾ tax-calculator/
        common.utilities.js
        ...
```
3. Reused common logic in the across target class/module will have a separate common directory and files in root test directory.
```
▾ test/
  ▾ common-utilities/
      test-loop.js
      fake-db.js
  ▾ finance/
      ...
```





