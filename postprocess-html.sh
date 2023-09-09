#!/usr/bin/env bash

set -eo pipefail

html_file="resume.html"

email='dave.yarwood@gmail.com'
email_pattern='dave\.yarwood@gmail\.com'
email_link="<a href=\"mailto:$email?subject=Job+opportunity\">$email</a>"

alda_github_url='https://github.com/alda-lang/alda'
alda_github_url_pattern='https://github\.com/alda-lang/alda'
alda_github_link="<a href=\"$alda_github_url\">$alda_github_url</a>"

echo "Adjusting $html_file..."

sed \
  -i \
  -e "s|$email_pattern|$email_link|" \
  -e "s|$alda_github_url_pattern|$alda_github_link|" \
  "$(dirname "$0")/$html_file"

# HACK: Move the sections around to be in the order I want them. This is very
# hacky, but hey, it works!
#
# TODO: Consider doing this properly by forking the theme and adjusting the HTML
# that's generated, to begin with. (While I'm at it, I could add the email
# mailto: link directly to the template, and then I could remove one of the
# hacks above, too.)

before_sections="$(mktemp)"
skills_section="$(mktemp)"
experience_section="$(mktemp)"
projects_section="$(mktemp)"
education_section="$(mktemp)"
after_sections="$(mktemp)"

section_file() {
  local n="$1"

  case "$n" in
    0)
      echo "$before_sections"
      ;;
    1)
      echo "$skills_section"
      ;;
    2)
      echo "$experience_section"
      ;;
    3)
      echo "$projects_section"
      ;;
    4)
      echo "$education_section"
      ;;
    5)
      echo "$after_sections"
      ;;
    *)
      >&2 echo "Unexpected section number: $n"
      exit 1
      ;;
  esac
}

section_number=0

# The amount of space here is important because there are other "sectionLine"
# divs nested deeper that _don't_ end a section.
last_line_of_section="            <div class=\"sectionLine\"></div>"

while IFS="" read -r line; do
  if [[ "$line" == "$last_line_of_section" ]]; then
    _="$((section_number++))"
  fi

  echo "$line" >> "$(section_file "$section_number")"
done < "$(dirname "$0")/$html_file"

# Now that I've captured the sections separately, I can re-order them.
cat \
  "$before_sections" \
  "$experience_section" \
  "$education_section" \
  "$projects_section" \
  "$skills_section" \
  "$after_sections" \
  > "$html_file"
