
DIRS=$(dir $(wildcard */makefile))
BINS=$(join $(DIRS),$(patsubst %/,%.bin,$(DIRS)))
LBRS=$(join $(DIRS),$(patsubst %/,%.lbr,$(DIRS)))

all: $(BINS)

$(BINS): FORCE
	$(MAKE) -C $(dir $@)

$(LBRS): $(BINS)
	$(MAKE) -C $(dir $@) lbr

lbr: $(LBRS)
	cat $(LBRS) > fileutils.lbr

clean: FORCE
	rm -f fileutils.lbr
	for DIR in $(DIRS) ; do \
	$(MAKE) -C $$DIR clean ; \
	done

FORCE:
