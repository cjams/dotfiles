

ISO_LABEL?=dev

.PHONY: all clean rown uown

all:
	./build.sh -v -L $(ISO_LABEL)
rown:
	chown -R root:root .

uown:
	chown -R $(OWNER):$(OWNER_GRP) .

clean:
	rm -rf out work
