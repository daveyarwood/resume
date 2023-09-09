# resume

This repo builds my resume / CV from a JSON file, using the [JSON Resume]
standard tooling.

My resume is available here in various formats:

* https://djy.io/resume.html
* https://djy.io/resume.pdf
* https://djy.io/resume.json

## Automatic deployment

I've set up a GitHub Actions workflow that automatically builds `resume.html`
and `resume.pdf` and deploys those files (along with `resume.json`) to GitHub
Pages.

I have djy.io set up to [automatically serve the files hosted in GitHub
Pages][djy.io-setup] when you navigate to the URLs listed above, using Netlify's
awesome [rewrites feature][netlify-redirects-rewrites].

## Local development

### Setup

To install dependencies, run:

```bash
yarn install
```

### Generating resume.html and resume.pdf

To generate these files, run:

```bash
yarn build
```

[JSON Resume]: https://jsonresume.org
[resumed]: https://github.com/rbardini/resumed
[jsonresume-theme-one]: https://www.npmjs.com/package/jsonresume-theme-one
[djy.io-setup]: https://github.com/daveyarwood/djy.io/blob/master/_redirects
[netlify-redirects-rewrites]: https://docs.netlify.com/routing/redirects/
