#!/bin/sh
echo "Linting the markdown files"
for md_file in $(find ./ -type f -name "*.md"); do
    npx markdownlint-cli2-fix $md_file
done

echo "compiling and formating the cairo files"
for cairo_file in $(find contracts/ -type f -name "*.cairo"); do
    echo $cairo_file
    starknet-compile $cairo_file >/dev/null
    cairo-format -i $cairo_file
done
echo "done"
