pip install cairo-lang asynctest pytest >/dev/null
echo "compiling the contracts"
for cairo_file in $(find contracts/ -type f -name "*.cairo"); do
    starknet-compile $cairo_file >/dev/null
done;
echo "done"
pytest -W ignore::DeprecationWarning
