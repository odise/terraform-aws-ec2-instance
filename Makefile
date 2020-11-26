.PHONY: changelog release

changelog:
	git-chglog -o CHANGELOG.md --next-tag `semtag final -s minor -o` v1.0.0..

release:
	semtag final -s minor