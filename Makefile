export README_TEMPLATE_FILE = $(shell pwd)/README.md.gotmpl

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
