# Change logs

## 0.3.1
- Revert "Use HTTPS in all connections".

## 0.3.1
- Use HTTPS in all connections.

## 0.3.0
### Critical Bug Fix
- Fix a bug where sub price is not found.
  - If sub price is not found, Integer can't parse argument because it's String.

## 0.2.7
- Make price integer.

## 0.2.6
- Fetch the price of the art.

## 0.2.5
- Make agent selectable in Attributes class.

## 0.2.4
- Do not show rank in art title.

## 0.2.3
- Do not lock gem versions in 'dmm-crawler.gemspec'.
- Change the author name element due to it is not found.

### Security Changes
- Lock the RuboCop version over `0.49.0`.

### Breaking Changes
- Reduce the ranking size to ten.

## 0.2.2
- Do not manage 'Gemfile.lock'.

## 0.2.1
- Add an attribute for author.

## 0.2.0
- Make optional configuration settable for Mechanize.
- Fix a bug where data-src is not found
- Do not fix types of submedia.
- Update `README.md`.

### Breaking Changes
- Do not use passed value of submedia type.

## 0.1.5
- Do not crawl columns related to description.

## 0.1.4
- Move the series to last.

## 0.1.3
- Add crawling more information.

## 0.1.2
- Extract Attributes klass from Ranking klass.
- Support art page.
- Add an attribute for submedia.

## 0.1.1
- Convert double quotes to single qoutes for description_raw.

## 0.1.0
- Add an attribute raw data of description that include HTML tag.

## 0.0.7
### Critical bug fix
- Replace url with image_url
- Fix the bug where description is empty.

## 0.0.6
- Refactor codes related to attributes for the art.

## 0.0.5
- Add a function to fetch description.

## v0.0.4
- Fix the code for chech an argument.
- Rename an attribute from url to title_link.
- Improve readability of about arguments.

## v0.0.3
- Rename the method from books to arts.
- Correct examples for `README.md`.

## v0.0.2
- Write docs for dmm-crawler.
- Add a function to fetch tags for the title.

## v0.0.1
- Implement fetch the ranking for the DMM.R18's rankings.
