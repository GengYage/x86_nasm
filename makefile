build/%.bin: src/%.asm
	nasm -f bin $< -o $@

%.img: build/%.bin
ifeq ("$(wildcard master.img)", "")
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat master.img
endif
	dd if=$< of=master.img bs=512 count=1 conv=notrunc

.PHONY:bochs
%: %.img
	bochs -q -unlock
	rm -rf bx_enh_dbg.ini

.PHONY:clean
clean:
	rm -rf build/*.bin
	rm -rf master.img