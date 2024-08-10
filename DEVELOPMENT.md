# Development

As the README is automatically generated, this file will serve as reference for how this application works.

* Entries to the list are stored as yml files in the [`software` directory](software/).
* Tags are stored as yml files in the [`tags` directory](tags/).
* Platforms are stored as yml files in the [`platforms` directory](platforms/).
* Licenses are stored in a single [`licenses.yml` file](licenses.yml).
* When commits are merged into the main branch, GitHub Actions automatically:
  * Builds the HTML pages and pushes them to GitHub Pages.
  * Builds the generated README.md file and pushes it to the repository.
* When pull requests are made, GitHub Actions will check syntax and confirm builds succeed before allowing a rebase and merge.
* Different build/chore tasks are stored in [`Makefile`](Makefile).
* The [hecat](https://github.com/njiticc/hecat) application is used to convert the yml entry files into markdown pages.
* The [sphinx](https://github.com/sphinx-doc/sphinx) application is used to convert the generated markdown files into HTML pages. The [`.hecat/conf.py`](.hecat/conf.py) file is sphinx's configuration.
