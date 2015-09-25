import os
delimiter = ';====================='
PATH = '..'
# bad practice to hardcode path
asm_files = [x for x in os.listdir(PATH) if x.endswith('.asm')]
asm_files.sort()
index = open(PATH+'/README','w')
# use os.path.join instead

intro_string='''
The following repo contains assembly language codes
for various assignments which were the part of 
Microprocessor Architecture (MPA) subject for my 
2nd year. Feel free to refer and update them!

The files were assembled and executed
in a Linux (Fedora and Ubuntu) 64 based systems
with Intel microprocessors.


Dependencies:

1. nasm ("$ sudo apt-get install nasm" for ubuntu)


Execution process:

1. The lazy approach (assuming nasm+ld)

to assemble, link and run file.asm
$ make file=file.asm

to run a preassembled file.asm
$ ./file



Notes: 

1. by default it assembles in 64 bit mode.
to change that:
$ make file=file.asm bits=32

2. being lazy, i included
./$(file) command in the make file
which is bad practice

3. the additional flags (-g,-F) are for debugging purposes

4. feel free to post an issue in case of any difficulty


File List(only checked ones):

'''
index.write(intro_string)
asm_files_with_intro=[]
for asm_file in asm_files:
	with open(PATH+'/'+asm_file) as f:
		contents = f.read()
		sp = contents.split(delimiter)
		if len(sp) > 1:
			doc = sp[1]
			doc = doc.split('\n')
			doc = "\n".join([" "*4+x[1:] for x in doc])
			index.write(asm_file+"\n"+doc+"\n\n")
			asm_files_with_intro.append(asm_file)
		else:
			print ('no intro found for '+asm_file)

index.write("Total "+str(len(asm_files_with_intro))+" files.")
index.close()

