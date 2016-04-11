# Contributing Code

- Checkout the latest master to make sure the feature hasn't been implemented or
the bug hasn't been fixed yet.

- Check the issue tracker to make sure someone already hasn't requested it and/or
contributed to it.

- Fork the repo.

- We follow LLVM style code formatting. We use [`clang-format`](http://clang.llvm.org/docs/ClangFormat.html) to achieve this.

    The easiest way to do this is using [`ClangFormat-Xcode`](https://github.com/travisjeffery/ClangFormat-Xcode) plugin by [Travis Jeffery](https://github.com/travisjeffery). Here are the steps to get you started with it.

    - Install Homebrew. Find instructions [here](http://brew.sh/).
    - Run the following on Terminal `brew install clang-format`.
    - Install `Alcatraz` package manager for Xcode. Find instructions [here](http://alcatraz.io/).
    - Start Xcode and find Alcatraz under Window > Package Manager (or simply press &#8984;+9 key combination).
    - Search for *ClangFormat* and install.
    - Restart Xcode.

    You'll find `Clang Format` under Edit in Xcode. Enable *Format on Save* and make sure you use *LLVM* configuration.

- Make your change.

- Push to your fork. Write a [good commit message][commit]. Submit a pull request.

  [commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

Others will give constructive feedback.
This is a time for discussion and improvements,
and making the necessary changes will be required before we can
merge the contribution.
