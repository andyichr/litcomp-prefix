run:
	./src/sh/run.sh

test:
	./src/sh/run.sh TEST

clean:
	rm -rf .build ; ( cd litcomp && make clean )
