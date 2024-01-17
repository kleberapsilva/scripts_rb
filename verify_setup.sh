#!/usr/bin/env bash -l
#------------------------------------------------------------------------------------------------------------------------
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -e 
#------------------------------------------------------------------------------------------------------------------------
main() { 
	rake setup:mac
}
#------------------------------------------------------------------------------------------------------------------------
main
#------------------------------------------------------------------------------------------------------------------------
