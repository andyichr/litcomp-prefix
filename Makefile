run:
	./src/sh/run.sh

docs:
	./src/sh/run.sh DOCS

test:
	./src/sh/run.sh TEST

run-multi:
	./src/sh/run-multi.sh

clean:
	rm -rf .build ; ( cd litcomp && make clean )

.PHONY: run test clean
